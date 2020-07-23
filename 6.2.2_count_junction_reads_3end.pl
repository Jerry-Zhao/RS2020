#! /usr/local/perl -w

@filenames=(
            "GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2",
	    "GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2",
	    "GSE90205_GingerasLab_8w_Cortex_rep1","GSE90205_GingerasLab_8w_Cortex_rep2"
           );

@chromo=("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15",
         "chr16","chr17","chr18","chr19","chrX","chrY");

foreach $sam (@filenames)
{
print "Working on File: $sam\n";
open(OUT,">Result/06_RSexon/count/$sam.junc_count_3end.txt")||die("Can't write OUT:$!\n");


foreach $chromosome (@chromo)
{
open(INA,"Result/Merged_RSsiteExon_RSexon_0528.txt")||die("Can't open INA:$!\n");
open(INB,"/media/Project/tmp/Split/$sam\.sam.$chromosome")||die("Can't open INC:$!\n");
  
print "Working on chromosome: $chromosome\n";

while(<INA>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:([+|-])\s+([\w\.\-]+)\s*$/)
 {
  if($3<$2){print "error wrong exon Start-End: $_\n";}
  if($1 eq $chromosome)
  {
   if($4 eq "+"){$site{$3}="$1:$2-$3:$4:$5";$count{$3}=0;} ## 5' end 
   elsif($4 eq "-"){$site{$2}="$1:$2-$3:$4:$5";$count{$2}=0;} ## 5' end
   else{print "error strand $_\n";}
  }
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^([\w\.\-\:]+)\t(\d+)\t(\w\w?)\t(\d+)\t255\t(\w+)\t\=\t/)
 {
  $chr="chr$3"; if($chr ne $chromosome){print "error wrong sam-chr: $_\n";} 
  $start=$4-1; $start_loci=$4;
  $cigar=$5;
  ## M: match; useful
  ## I: read has insertion compared to reference genome; no use
  ## D: read has deletion compared to the genome; useful
  ## H: hard clip of the reads, no use
  ## S: soft clip of the reads, no use
  ## N: skipped regions, usually introns; useful
  ## End = Start + Ms + Ns + Ds

  ## gene in minus strand; read in plus strand 
  if(($2==99) or ($2==147)) ## left of the pair; first in the sam file 
  {
   if(!exists $count{$start_loci}) ## reads not start at the exon end
   {
    $label1=0; ## prevent reads end at the exon end, and no splicing
    while($cigar=~/(\d+)([A-Z])/g)
    {
     if($2 eq "M")
     {
      $loci=$start+1;
      if((exists $count{$loci}) and ($label1>0)){$count{$loci}++;}
      $start=($start + 1) + $1 -1;
     }     
     elsif($2 eq "D"){$start=($start + 1) + $1 -1;}
     elsif($2 eq "N"){$start=($start + 1) + $1 -1;$label1++;}
     elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
     else{print "error CIGAR $cigar\n";}
    }
   }
  }
  elsif(($2==163) or ($2==83)) ## gene in plus strand; read in minus strand
  {
   # $label1=$label2=0; ## prevent reads end at the exon end, and no splicing
   while($cigar=~/(\d+)([A-Z])/g)
   {
    if($2 eq "M"){$start=$start+$1-1 +1;}
    elsif($2 eq "D"){$start=$start+$1-1 +1;}
    elsif($2 eq "N")
    {
     $loci=$start;
     if(exists $count{$loci}){$count{$loci}++;}
     $start=$start+$1-1 +1;
    }
    elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
    else{print "error CIGAR $cigar\n";}
   }
  }
  else{print "error FLAG: $_\n";}
 }
 else{print "error2\t$_\n";}
}

foreach (sort {$a<=>$b} keys (%count)){print OUT "$site{$_}\t$count{$_}\n";}
%count=(); %site=();
 
close INA; close INB;
}

close OUT;
}

