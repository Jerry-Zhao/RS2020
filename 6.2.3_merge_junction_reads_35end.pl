#! /usr/local/ perl -w
open(INA,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1.junc_count_5end.txt")||die("Can't open INA:$!\n");
open(INB,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2.junc_count_5end.txt")||die("Can't open INB:$!\n");
open(INC,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1.junc_count_5end.txt")||die("Can't open INC:$!\n");
open(IND,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2.junc_count_5end.txt")||die("Can't open IND:$!\n");
open(INE,"Result/06_RSexon/count/GSE90205_GingerasLab_8w_Cortex_rep1.junc_count_5end.txt")||die("Can't open INE:$!\n");
open(INF,"Result/06_RSexon/count/GSE90205_GingerasLab_8w_Cortex_rep2.junc_count_5end.txt")||die("Can't open INF:$!\n");

open(ING,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1.junc_count_3end.txt")||die("Can't open ING:$!\n");
open(INH,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2.junc_count_3end.txt")||die("Can't open INH:$!\n");
open(INI,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1.junc_count_3end.txt")||die("Can't open INI:$!\n");
open(INJ,"Result/06_RSexon/count/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2.junc_count_3end.txt")||die("Can't open INJ:$!\n");
open(INK,"Result/06_RSexon/count/GSE90205_GingerasLab_8w_Cortex_rep1.junc_count_3end.txt")||die("Can't open INK:$!\n");
open(INL,"Result/06_RSexon/count/GSE90205_GingerasLab_8w_Cortex_rep2.junc_count_3end.txt")||die("Can't open INL:$!\n");

open(OUT,">Result/06_RSexon/Merged_junction_reads_5_3end.xls")||die("Can't write OUT:$!\n");

while(<INA>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$cell5rep1{$1}=$2; $total{$1}=1;}else{print "error1\t$_\n";}}
while(<INB>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$cell5rep2{$1}=$2; $total{$1}=1;}else{print "error2\t$_\n";}}
while(<INC>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$nuclear5rep1{$1}=$2; $total{$1}=1;}else{print "error3\t$_\n";}}
while(<IND>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$nuclear5rep2{$1}=$2; $total{$1}=1;}else{print "error4\t$_\n";}}
while(<INE>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$mrna5rep1{$1}=$2; $total{$1}=1;}else{print "error5\t$_\n";}}
while(<INF>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$mrna5rep2{$1}=$2; $total{$1}=1;}else{print "error6\t$_\n";}}

while(<ING>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$cell3rep1{$1}=$2; $total{$1}=1;}else{print "error7\t$_\n";}}
while(<INH>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$cell3rep2{$1}=$2; $total{$1}=1;}else{print "error8\t$_\n";}}
while(<INI>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$nuclear3rep1{$1}=$2; $total{$1}=1;}else{print "error9\t$_\n";}}
while(<INJ>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$nuclear3rep2{$1}=$2; $total{$1}=1;}else{print "error10\t$_\n";}}
while(<INK>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$mrna3rep1{$1}=$2; $total{$1}=1;}else{print "error11\t$_\n";}}
while(<INL>){chomp;if(/^(chr[\w\.\-\:\+]+)\t(\d+)$/){$mrna3rep2{$1}=$2; $total{$1}=1;}else{print "error12\t$_\n";}}

print OUT "\tCell5rep1\tCell5rep2\tNuclear5rep1\tNuclear5rep2\tmRNA5rep1\tmRNA5rep2\t";
print OUT "Cell3rep1\tCell3rep2\tNuclear3rep1\tNuclear3rep2\tmRNA3rep1\tmRNA3rep2\n";
foreach (keys %total)
{
 print OUT "$_\t$cell5rep1{$_}\t$cell5rep2{$_}\t$nuclear5rep1{$_}\t$nuclear5rep2{$_}\t$mrna5rep1{$_}\t$mrna5rep2{$_}\t$cell3rep1{$_}\t$cell3rep2{$_}\t$nuclear3rep1{$_}\t$nuclear3rep2{$_}\t$mrna3rep1{$_}\t$mrna3rep2{$_}\n";
}
close OUT; 
