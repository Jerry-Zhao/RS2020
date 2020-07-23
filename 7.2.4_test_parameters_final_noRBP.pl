#! /usr/local/perl -w
#
# %TC:0.75   %T:0.4   3SS:9.3
# RSsites : 20	 17
# Hs6st3  : 2640	 0
# RSintron: 23690	 1
# CtrlIntron: 62268	 5

# RSintron:  chr10:69590385_ENSMUSG00000069601_Ank3	AGGTAAGT	TCTCTGTTTTATTTTTCCTT	0.9	0.7	0.2	0.050.05	TCTGTTTTATTTTTCCTTAGGTA	11.64	12.84	14.21	AAGGTAAGT	11.00	15.48	12.19	12.71


# CtrlIntron:  ENSMUSG00000052572_Dlg2_exon7_96269	AGGTGAGT	TACTGTGCTTGTCTCTCCTC	0.8	0.45	0.35	0.150.05	CTGTGCTTGTCTCTCCTCAGGTG	12.81	13.44	12.81
# CtrlIntron:  ENSMUSG00000008658_Rbfox1_exon4_264570	AGGTAAGC	CTTCTTTTCTTCCTTCCACT	0.95	0.55	0.4	0	0.05	TCTTTTCTTCCTTCCACTAGGTA	11.96	12.64	15.08
# CtrlIntron:  ENSMUSG00000069670_Nkain2_exon1_299264	AGGTGAGT	TTCTGTGATGTCCTTATTCT	0.75	0.55	0.2	0.150.1	CTGTGATGTCCTTATTCTAGGTG	10.50	11.07	9.04
# CtrlIntron:  ENSMUSG00000060882_Kcnd2_exon1_148388	AGGTGAGT	CTTGATTTCTTATTTTTAAC	0.75	0.6	0.15	0.050.2	TGATTTCTTATTTTTAACAGGTG	9.44	10.39	10.62
# CtrlIntron:  ENSMUSG00000068205_Macrod2_exon8_182163	AGGTGAGT	GGTTTTAGCTTTTCATTTCT	0.75	0.6	0.15	0.150.1	TTTTAGCTTTTCATTTCTAGGTG	10.24	10.78	12.89

open(INA,"Result/07_predict/Merged_RSsites_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/Merged_Hs6st3_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INC,"Result/07_predict/Merged_RSintrons_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(IND,"Result/07_predict/Merged_CtrlIntrons_percent_3SS.xls")||die("Can't open IND:$!\n");

print "Please enter the %TC cutoff:\n";
chomp($tc1=<STDIN>);
print "Please enter the %T cutoff:\n";
chomp($t1=<STDIN>);
print "Please enter the 3SS cutoff:\n";
chomp($ss3=<STDIN>);


$a1=$a2=$b1=$b2=$c1=$c2=0;
while(<INA>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t[ATCG]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $a1++;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT"))
  {
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3) ){$a2++; print "RSsite:  $_\n";}
  }
 }
 else{print "error1\t$_\n";}
}


while(<INB>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t[ATCG]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $b1++;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT"))
  {
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3)){$b2++; print "Hs6st3:  $_\n";}
  }
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t[ATCG]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $c1++;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT"))
  {
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3)){$c2++; print "RSintron:  $_\n";}
  }
 }
 else{print "error3\t$_\n";}
}


while(<IND>)
{
 chomp;
 if(/^(EN[\w\:\-\+]+)\t([ATCG]+)\t[ATCG]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $d1++;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT"))
  {
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3)){$d2++; print "CtrlIntron:  $_\n";}
  }
 }
 else{print "error3\t$_\n";}
}


print "%TC:$tc1   %T:$t1   3SS:$ss3\n";
print "RSsites : $a1\t $a2\n";
print "Hs6st3  : $b1\t $b2\n";
print "RSintron: $c1\t $c2\n";
print "CtrlIntron: $d1\t $d2\n";

