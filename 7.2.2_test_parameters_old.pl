#! /usr/local/perl -w
#
## %TC:0.75   %T:0.4   3SS:9   5SS:0
# RSsites : 20	 17
# Hs6st3  : 2640	 0
# RSintron: 23690	 2

# %TC:0.7   %T:0.3   3SS:7   5SS:8
# RSsites : 20	 17
# Hs6st3  : 2640	 0
# RSintron: 23690	 15


open(INA,"Result/07_predict/Merged_RSsites_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/Merged_Hs6st3_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INC,"Result/07_predict/Merged_RSintrons_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");

print "Please enter the %TC cutoff:\n";
chomp($tc1=<STDIN>);
print "Please enter the %T cutoff:\n";
chomp($t1=<STDIN>);
print "Please enter the 3SS cutoff:\n";
chomp($ss3=<STDIN>);
print "Please enter the 5SS cutoff:\n";
chomp($ss5=<STDIN>);


$a1=$a2=$b1=$b2=$c1=$c2=0;
while(<INA>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t[ATCG]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $a1++;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT"))
  {
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3) and ($6 >= $ss5)){$a2++; print "RSsite:  $_\n";}
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
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3) and ($6 >= $ss5)){$b2++; print "Hs6st3:  $_\n";}
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
   if(($3 >= $tc1) and ($4 >= $t1) and ($5 >= $ss3) and ($6 >= $ss5)){$c2++; print "RSintron:  $_\n";}
  }
 }
 else{print "error3\t$_\n";}
}

print "%TC:$tc1   %T:$t1   3SS:$ss3   5SS:$ss5\n";
print "RSsites : $a1\t $a2\n";
print "Hs6st3  : $b1\t $b2\n";
print "RSintron: $c1\t $c2\n";

