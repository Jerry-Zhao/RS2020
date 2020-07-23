#! /usr/local/perl -w
#
#
#                                                        Total-reads    Exon-overlap  Non-overlap
# GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1         27,773,275   15041407      12731868
# GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2         23,938,182   12912284      23757766
# GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1           39,110,710    7732952      55135524
# GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2          214,271,904   50112608     219294820
# GSE90205_GingerasLab_8w_Cortex_rep1                     125,317,299   90845190     253766929
# GSE90205_GingerasLab_8w_Cortex_rep2                     128,743,856   90920964     291589821
# GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1       30,285,385    4683306     317191900
# GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2       37,417,668    4809457     349800111
# GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3       31,687,442    4501369     376986184
# GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4       44,934,439    5535651     416384972
# GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1       35,105,801    6450438     445040335
# GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2       41,194,346    7092341     479142340
# GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3       30,938,829    6355636     503725533
# GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4       33,582,505    5332754     531975284
# GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1 39,488,158    7802245     563661197
# GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2 33,693,124    5861476     591492845



open(INAA,"count/exonic/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1_exonic_gene.txt")||die("Can't open INA1:$!\n");
open(INAB,"count/exonic/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2_exonic_gene.txt")||die("Can't open INA1:$!\n");

open(INBA,"count/exonic/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1_exonic_gene.txt")||die("Can't open INA2:$!\n");
open(INBB,"count/exonic/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2_exonic_gene.txt")||die("Can't open INA2:$!\n");

open(INCA,"count/exonic/GSE90205_GingerasLab_8w_Cortex_rep1_exonic_gene.txt")||die("Can't open INA3:$!\n");
open(INCB,"count/exonic/GSE90205_GingerasLab_8w_Cortex_rep2_exonic_gene.txt")||die("Can't open INA3:$!\n");

open(INDA,"count/exonic/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1_exonic_gene.txt")||die("Can't open INA4:$!\n");
open(INDB,"count/exonic/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2_exonic_gene.txt")||die("Can't open INA4:$!\n");
open(INEA,"count/exonic/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3_exonic_gene.txt")||die("Can't open INA5:$!\n");
open(INEB,"count/exonic/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4_exonic_gene.txt")||die("Can't open INA5:$!\n");

open(INFA,"count/exonic/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1_exonic_gene.txt")||die("Can't open INA6:$!\n");
open(INFB,"count/exonic/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2_exonic_gene.txt")||die("Can't open INA6:$!\n");
open(INGA,"count/exonic/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3_exonic_gene.txt")||die("Can't open INA7:$!\n");
open(INGB,"count/exonic/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4_exonic_gene.txt")||die("Can't open INA7:$!\n");

open(INHA,"count/exonic/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1_exonic_gene.txt")||die("Can't open INA8:$!\n");
open(INHB,"count/exonic/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2_exonic_gene.txt")||die("Can't open INA8:$!\n");

open(INGENOMEP,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.exon")||die("Can't open INGENOMEP:$!\n");
open(INGENOMEM,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.exon")||die("Can't open INGENOMEM:$!\n");
open(OUT,">Result/FPKM_merged_exonic_gene_Jerry.xls")||die("Can't write OUT:$!\n");


while(<INGENOMEP>)
{
 chomp;
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(EN\w+\_[\w\.\-]+)\_exon\d+\t\+$/)
 {
  $exonlength=$2-$1+1;
  if(exists $exonlen{$3}){$exonlen{$3}+=$exonlength;}else{$exonlen{$3}=$exonlength;}
 }
 else{print "error exon: $_\n";}
}

while(<INGENOMEM>)
{
 chomp;
 if(/^chr\w\w?\:(\d+)\-(\d+)\:(EN\w+\_[\w\.\-]+)\_exon\d+\t\-$/)
 {
  $exonlength=$2-$1+1;
  if(exists $exonlen{$3}){$exonlen{$3}+=$exonlength;}else{$exonlen{$3}=$exonlength;}
 }
 else{print "error exon: $_\n";}
}

while(<INAA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count1a{$1}=$2;}else{print "error count: $_\n";}}
while(<INAB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count1b{$1}=$2;}else{print "error count: $_\n";}}

while(<INBA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count2a{$1}=$2;}else{print "error count: $_\n";}}
while(<INBB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count2b{$1}=$2;}else{print "error count: $_\n";}}

while(<INCA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count3a{$1}=$2;}else{print "error count: $_\n";}}
while(<INCB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count3b{$1}=$2;}else{print "error count: $_\n";}}

while(<INDA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count4a{$1}=$2;}else{print "error count: $_\n";}}
while(<INDB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count4b{$1}=$2;}else{print "error count: $_\n";}}
while(<INEA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count4c{$1}=$2;}else{print "error count: $_\n";}}
while(<INEB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count4d{$1}=$2;}else{print "error count: $_\n";}}

while(<INFA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count5a{$1}=$2;}else{print "error count: $_\n";}}
while(<INFB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count5b{$1}=$2;}else{print "error count: $_\n";}}
while(<INGA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count5c{$1}=$2;}else{print "error count: $_\n";}}
while(<INGB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count5d{$1}=$2;}else{print "error count: $_\n";}}

while(<INHA>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count6a{$1}=$2;}else{print "error count: $_\n";}}
while(<INHB>){chomp;if(/^(EN\w+\_[\w\.\-]+)\t(\d+)$/){$count6b{$1}=$2;}else{print "error count: $_\n";}}

print OUT "\t";
print OUT "GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1\tGSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2\t";
print OUT "GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1\tGSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2\t";
print OUT "GSE90205_GingerasLab_8w_Cortex_rep1\tGSE90205_GingerasLab_8w_Cortex_rep2\t";
print OUT "GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1\tGSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2\t";
print OUT "GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3\tGSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4\t";
print OUT "GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1\tGSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2\t";
print OUT "GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3\tGSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4\t";
print OUT "GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1\tGSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2\n";

foreach (keys %count1a)
{
 $fpkm1a=int($count1a{$_}*(1000000/15041407)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits 
 $fpkm1b=int($count1b{$_}*(1000000/12912284)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 $fpkm2a=int($count2a{$_}*(1000000/7732952)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits 
 $fpkm2b=int($count2b{$_}*(1000000/50112608)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 $fpkm3a=int($count3a{$_}*(1000000/90845190)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm3b=int($count3b{$_}*(1000000/90920964)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 $fpkm4a=int($count4a{$_}*(1000000/4683306)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm4b=int($count4b{$_}*(1000000/4809457)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm4c=int($count4c{$_}*(1000000/4501369)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm4d=int($count4d{$_}*(1000000/5535651)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 $fpkm5a=int($count5a{$_}*(1000000/6450438)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm5b=int($count5b{$_}*(1000000/7092341)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm5c=int($count5c{$_}*(1000000/6355636)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm5d=int($count5d{$_}*(1000000/5332754)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 $fpkm6a=int($count6a{$_}*(1000000/7802245)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits
 $fpkm6b=int($count6b{$_}*(1000000/5861476)*(1000/$exonlen{$_})*100)/100; ## FPKM. two digits

 print OUT "$_\t$fpkm1a\t$fpkm1b\t$fpkm2a\t$fpkm2b\t$fpkm3a\t$fpkm3b\t$fpkm4a\t$fpkm4b\t$fpkm4c\t$fpkm4d\t";
 print OUT "$fpkm5a\t$fpkm5b\t$fpkm5c\t$fpkm5d\t$fpkm6a\t$fpkm6b\n";
}



