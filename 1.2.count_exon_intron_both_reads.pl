#! /usr/local/perl -w
## This program counts reads number for each genes from TopHat/STAR result SAM 
## This file will be the input file of edgeR analysis

@filenames=(
	  #  "GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2",
	  #  "GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2"
          # "GSE90205_GingerasLab_8w_Cortex_rep1","GSE90205_GingerasLab_8w_Cortex_rep2"
	  "GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2"
	  ,"GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3","GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4"
	  #,"GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2"
	  #,"GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3","GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4"
	  #,"GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1","GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2"
           );

@chromo=("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chrX","chrY");

foreach $sam (@filenames)
{

print "Working on File: $sam\n";

open(OUT,">$sam\_exonic_intronic_Jerry.txt")||die("Can't write OUT:$!\n");
 
my $total_reads=$exon_reads=$intron_reads=$overlap_reads=$intergenic_reads=0;

foreach $chromosome (@chromo)
{ 
 open(INA,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.exon")||die("Can't open INA:$!\n");
 open(INB,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.exon")||die("Can't open INB:$!\n");
 open(INC,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.intron")||die("Can't open INA:$!\n");
 open(IND,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.intron")||die("Can't open INB:$!\n");
 open(INE,"/media/Project/Split/$sam\.sam.$chromosome")||die("Can't open INC:$!\n");
 
 print "Working on chromosome: $chromosome\n";

 while(<INA>){chomp;if(/^(chr\w+)\:(\d+)-(\d+):[\w\.\-\(\)]+\_exon\d+\t\+$/){if($1 eq $chromosome){for($i=$2;$i<=$3;$i++){$plusexon{$i}=1;}}}
  else{print "error1\t$_\n";}}
 while(<INB>){chomp;if(/^(chr\w+)\:(\d+)-(\d+):[\w\.\-\(\)]+\_exon\d+\t\-$/){if($1 eq $chromosome){for($i=$2;$i<=$3;$i++){$minusexon{$i}=1;}}}
  else{print "error2\t$_\n";}}
 while(<INC>){chomp;if(/^(chr\w+)\:(\d+)-(\d+):[\w\.\-\(\)]+\_intron\d+\t\+$/){if($1 eq $chromosome){for($i=$2;$i<=$3;$i++){$plusintron{$i}=1;}}}
  else{print "error3\t$_\n";}}
 while(<IND>){chomp;if(/^(chr\w+)\:(\d+)-(\d+):[\w\.\-\(\)]+\_intron\d+\t\-$/){if($1 eq $chromosome){for($i=$2;$i<=$3;$i++){$minusintron{$i}=1;}}}
  else{print "error4\t$_\n";}}

 while(<INE>)
 {
  chomp;
  if(/^([\w\.\:\-]+)\t(\d+)\t(\w\w?)\t(\d+)\t\d+\t(\w+)\t\=\t\d+\t[\d\-]+\t[A-Z]+\t/)
  {

  ### Right strand-specific: + 99/147;  - 163/83
#  if(($2 == 99) or ($2 == 147)){$str="plus"; $overlap="plus_over";}
#  elsif(($2 == 163) or ($2 == 83)){$str="minus"; $overlap="minus_over";}
#  else{print "error Strand-FLAG: $_\n";}

  ### Wrong strand-specific RNA-seq, reads mapped to gene opposite strand 
   if(($2 == 99) or ($2 == 147)){$stre="minusexon"; $stri="minusintron";}
   elsif(($2 == 163) or ($2 == 83)){$stre="plusexon";$stri="plusintron";}
   else{print "error Strand-FLAG: $_\n";}

   $total_reads++; ## total reads (not read-pairs)

   $chr="chr$3";   ## read mapping chromosome
   if($chr ne $chromosome){print "error wrong sam-chr: $_\n";}

   $start=$4;             ## read mapping start
   $cigar=$5; ## using this to define the end position of the read
    ## M: match   
    ## I: read has insertion compared to the reference genome; no use for gene count
    ## D: read has deletion compared to the genome; useful
    ## H: hard clip of the reads; no use
    ## S: soft clip of the read;  no use
    ## N: skipped region of the genome; useful, intron region
    ## 
    ## End = Start + Ms + Ns + Ds.          

   if(($2 == 99) or ($2 == 163)) ## first of the pair
   {
    $label_exon=$label_intron=0;
    print "Processes lines: $total_reads\n" if($total_reads%1000000==0);

    while($cigar=~/(\d+)([A-Z])/g) 
    {
     if($2 eq "M")
     {
      for ($j=$start; $j<=($start+$1-1); $j++)
      {
       if(exists $$stre{$j}) {$label_exon++;}   ## read overlap with exons
       if(exists $$stri{$j}) {$label_intron++;} ## read overlap with introns
      }
      $start=$start+$1; ## End of this match 
     }
     elsif(($2 eq "D") or ($2 eq "N")){$start=$start+$1;}## Add the insertion region
    }

    if(($label_exon>0) and ($label_intron>0)) {$overlap_reads++;} # read overlap with exon and intron
    elsif($label_exon>0){$exon_reads++;}     # read overlap with exon only
    elsif($label_intron>0){$intron_reads++;} # read overlap with intron only
    else{$intergenic_reads++;}               # read in intergenic regions
   }

   if(($2 == 147) or ($2 == 83)) ## second of the pair
   {
    $label_exon=$label_intron=0; 
    print "Processes lines: $total_reads\n" if($total_reads%1000000==0);

    while($cigar=~/(\d+)([A-Z])/g)
    {
     if($2 eq "M")
     {
      for ($j=$start; $j<=($start+$1-1); $j++)
      {
       if(exists $$stre{$j}) {$label_exon++;}   ## read overlap with exons
       if(exists $$stri{$j}) {$label_intron++;} ## read overlap with introns
      }
      $start=$start+$1; ## End of this match 
     }
     elsif(($2 eq "D") or ($2 eq "N")){$start=$start+$1;}## Add the insertion region
    }
    
    if(($label_exon>0) and ($label_intron>0)) {$overlap_reads++;} # read overlap with exon and intron
    elsif($label_exon>0){$exon_reads++;}     # read overlap with exon only
    elsif($label_intron>0){$intron_reads++;} # read overlap with intron only
    else{$intergenic_reads++;}               # read in intergenic regions
   }
  }
  else{print "error2\t$_\n";}
 }

 foreach (keys %plusexon){delete $plusexon{$_};}
 foreach (keys %plusintron){delete $plusintron{$_};}
 foreach (keys %minusexon){delete $minusexon{$_};}
 foreach (keys %minusintron){delete $minusintron{$_};}
 close INA; close INB; close INC; close IND; close INE;
}

print OUT "Total_reads:  $total_reads\n";
print OUT "Exonic_reads: $exon_reads\n";
print OUT "Intronic_reads: $intron_reads\n";
print OUT "Exonic_Intronic_reads: $overlap_reads\n";
print OUT "Intergenic_reads: $intergenic_reads\n";

close OUT;
}

