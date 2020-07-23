#! /usr/local/perl -w

@filenames=(
            "GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2",
	    "GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3","GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4",
	    "GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2",
	    "GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3","GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4",
	    "GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1","GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2"
#	     "GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2",
#	     "GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1","GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2",
#	     "GSE90205_GingerasLab_8w_Cortex_rep1","GSE90205_GingerasLab_8w_Cortex_rep2"
#            "GSE83474_Male6wWT_cortex_CellRNA_rep1","GSE83474_Male6wWT_cortex_CellRNA_rep2",
#            "GingerasLab_8w_Cortex_rep1","GingerasLab_8w_Cortex_rep2",
#            "GingerasLab_8w_Frontal_Cortex_rep1","GingerasLab_8w_Frontal_Cortex_rep2"
#            "GingerasLab_8w_Urinary_Bladder_rep1","GingerasLab_8w_Urinary_Bladder_rep2"
#            "GingerasLab_8w_Placenta_rep1","GingerasLab_8w_Placenta_rep2",
#            "GingerasLab_8w_Subcutaneous_Adipose_rep1","GingerasLab_8w_Subcutaneous_Adipose_rep2",
#            "Gingeras_Lab_8w_Stomach_rep1","Gingeras_Lab_8w_Stomach_rep2"
#            "Gingeras_Lab_8w_Small_intestine_rep1","Gingeras_Lab_8w_Small_intestine_rep2",
#            "Gingeras_Lab_8w_Ovary_rep1","Gingeras_Lab_8w_Ovary_rep2",
#            "Gingeras_Lab_8w_Mammary_gland_rep1","Gingeras_Lab_8w_Mammary_gland_rep2",
#            "Gingeras_Lab_8w_Cerebellum_rep1","Gingeras_Lab_8w_Cerebellum_rep2",
#            "Gingeras_Lab_8w_Large_intestine_rep1","Gingeras_Lab_8w_Large_intestine_rep2",
#            "Gingeras_Lab_8w_Heart_rep1","Gingeras_Lab_8w_Heart_rep2"
#            "Gingeras_Lab_8w_Kidney_rep1","Gingeras_Lab_8w_Kidney_rep2"
#            "Gingeras_Lab_8w_Duodenum_rep1","Gingeras_Lab_8w_Duodenum_rep2",
#            "Gingeras_Lab_8w_Adrenal_gland_rep1","Gingeras_Lab_8w_Adrenal_gland_rep2",
#            "Gingeras_Lab_8w_Colon_rep1","Gingeras_Lab_8w_Colon_rep2",
#            "Gingeras_Lab_8w_Gonadal_FatPad_rep1","Gingeras_Lab_8w_Gonadal_FatPad_rep2",
#            "Gingeras_Lab_8w_Liver_rep1","Gingeras_Lab_8w_Liver_rep2",
#            "Gingeras_Lab_8w_Lung_rep1","Gingeras_Lab_8w_Lung_rep2",
#            "Gingeras_Lab_8w_Spleen_rep1","Gingeras_Lab_8w_Spleen_rep2",
#            "Gingeras_Lab_8w_Testis_rep1","Gingeras_Lab_8w_Testis_rep2",
#            "Gingeras_Lab_8w_Thymus_rep1","Gingeras_Lab_8w_Thymus_rep2"
#            "GSE83474_Male6wWT_cortex_nuRNA_rep1","UnPub_Male6wWT_cortex_nuRNA_newrep1"
#            "UnPub_Male6wWT_cortex_nuRNA_rep3","UnPub_Male6wWT_cortex_nuRNA_rep4"
#            "GSE83474_Male6wWT_exc_nuRNA_rep1","GSE83474_Male6wWT_exc_nuRNA_rep2",
#            "GSE83474_Male6wWT_inh_nuRNA_rep1","GSE83474_Male6wWT_inh_nuRNA_rep2",
#            "UnPub_MaleP140WT_exc_nuRNA_rep1","UnPub_MaleP140WT_exc_nuRNA_rep2","UnPub_MaleP140WT_exc_nuRNA_rep3",
#            "UnPub_MaleP140WT_glia_nuRNA_rep1","UnPub_MaleP140WT_glia_nuRNA_rep2","UnPub_MaleP140WT_glia_nuRNA_rep3",
#            "UnPub_MaleP140WT_inh_nuRNA_rep1","UnPub_MaleP140WT_inh_nuRNA_rep2","UnPub_MaleP140WT_inh_nuRNA_rep3"
#            "UnPub_Male6wWT_cortex_CellRNA_rep3","UnPub_Male6wWT_cortex_CellRNA_rep4"
#            "GSE83474_Male6wWT_exc_nuRNA_rep3","GSE83474_Male6wWT_exc_nuRNA_rep4",
#            "GSE83474_Male6wWT_inh_nuRNA_rep3","GSE83474_Male6wWT_inh_nuRNA_rep4",
#            "GSE83474_Female18wWT_exc_nuRNA_rep1","GSE83474_Female18wWT_exc_nuRNA_rep2",
#            "UnPub_Female6wWT_exc_nuRNA_rep1","UnPub_Female6wWT_exc_nuRNA_rep2",
#            "UnPub_MaleP90WTCUS_mPFC_nuRNA_rep1","UnPub_MaleP90WTCUS_mPFC_nuRNA_rep2",
#            "UnPub_MaleP90WTCUS_mPFC_nuRNA_rep3","UnPub_MaleP90WTCUS_mPFC_nuRNA_rep4",
#            "UnPub_Male12wWT_exc_nuRNA_oldrep1",
#            "UnPub_Male12wWT_exc_nuRNA_rep1","UnPub_Male12wWT_exc_nuRNA_rep2",
#            "UnPub_Male12wWT_inh_nuRNA_oldrep1",
#            "UnPub_Male12wWT_inh_nuRNA_rep1","UnPub_Male12wWT_inh_nuRNA_rep2"
           );

@chromo=("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15",
         "chr16","chr17","chr18","chr19","chrX","chrY");

foreach $sam (@filenames)
{
print "Working on File: $sam\n";
open(OUT,">Junctions/$sam.junc_count.txt")||die("Can't write OUT:$!\n");


foreach $chromosome (@chromo)
{
open(INA,"Junctions/RS_sites_mm10_geneSense.xls")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Split/$sam\.sam.$chromosome")||die("Can't open INC:$!\n");
  
print "Working on chromosome: $chromosome\n";

while(<INA>)
{
 chomp;
 if(/^(chr\w\w?)\t([+|-])\t(\d+)\t(\w+)\t([\w\.\-]+)$/)
 {
  if($1 eq $chromosome){$site{$3}="$1\_$2\_$3\_$4\_$5";$count{$3}=0;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^([\w\.\-\:]+)\t(\d+)\t(\w\w?)\t(\d+)\t255\t(\w+)\t\=\t/)
 {
  $chr="chr$3"; if($chr ne $chromosome){print "error wrong sam-chr: $_\n";} 
  $start=$4;
  $cigar=$5;
  ## M: match; useful
  ## I: read has insertion compared to reference genome; no use
  ## D: read has deletion compared to the genome; useful
  ## H: hard clip of the reads, no use
  ## S: soft clip of the reads, no use
  ## N: skipped regions, usually introns; useful
  ## End = Start + Ms + Ns + Ds

  ## gene in minus strand; read in plus strand 
  if($2==99) ## left of the pair; first in the sam file 
  {
   $label=0;
   while($cigar=~/(\d+)([A-Z])/g)
   {
    if(($2 eq "M") or ($2 eq "D")){$start=$start+$1-1 +1;}
    elsif($2 eq "N"){$loci=$start-2; if(exists $site{$loci}){$label=1;push(@sitelist, $loci);} $start=$start+$1-1 +1;}
    elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
    else{print "error CIGAR $cigar\n";}
   }
  }
  elsif($2==147) ## right part of the pair; second in the sam file
  {
   while($cigar=~/(\d+)([A-Z])/g)
   {
    if(($2 eq "M") or ($2 eq "D")){$start=$start+$1-1 +1;}
    elsif($2 eq "N"){$loci=$start-2; if(exists $site{$loci}){$label=1;push(@sitelist, $loci);} $start=$start+$1-1 +1;}
    elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
    else{print "error CIGAR $cigar\n";}
   }
   
   if($label==1) ## this read pair covers RS site
   {
    foreach (@sitelist){$tmphash{$_}=0;}
    @newlist=keys %tmphash;
    foreach (@newlist){$count{$_}++;}
   }   
   @sitelist=(); %tmphash=();
  }
  elsif($2==163) ## gene in minus strand; read in plus strand
  {
   $label=0;
   while($cigar=~/(\d+)([A-Z])/g)
   {
    if(($2 eq "M") or ($2 eq "D")){$start=$start+$1-1 +1;}
    elsif($2 eq "N"){$start=$start+$1-1 +1; $loci=$start-2; if(exists $site{$loci}){$label=1;push(@sitelist, $loci);}}
    elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
    else{print "error CIGAR $cigar\n";}
   }
  }
  elsif($2==83) ## right part of the pair; second in the sam file
  {
   while($cigar=~/(\d+)([A-Z])/g)
   {
    if(($2 eq "M") or ($2 eq "D")){$start=$start+$1-1 +1;}
    elsif($2 eq "N"){$start=$start+$1-1 +1; $loci=$start-2; if(exists $site{$loci}){$label=1;push(@sitelist, $loci);}}
    elsif($2 eq "I" or $2 eq "H" or $2 eq "S"){}
    else{print "error CIGAR $cigar\n";}
   }

   if($label==1) ## this read pair covers RS site
   {
    foreach (@sitelist){$tmphash{$_}=0;}
    @newlist=keys %tmphash;
    foreach (@newlist){$count{$_}++;}
   }
   @sitelist=(); %tmphash=(); @newlist=(); 
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

