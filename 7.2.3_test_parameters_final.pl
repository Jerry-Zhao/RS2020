#! /usr/local/perl -w
#
#
# %TC:0.75   %T:0.4   3SS:9
# RSsites : 20     17
# Hs6st3  : 2640   0
# RSintron: 23690  2

# RSintron:  chr10:69590385_ENSMUSG00000069601_Ank3	AGGTAAGT	TCTCTGTTTTATTTTTCCTT	0.9	0.7	0.2	0.050.05	TCTGTTTTATTTTTCCTTAGGTA	11.64	12.84	14.21	AAGGTAAGT	11.00	15.48	12.19	12.71

# RSintron:  chr16:40427084_ENSMUSG00000061080_Lsamp	AGGTAAGT	TTTTCTACCTTGTCCATGAC	0.75	0.45	0.3	0.1	0.15	TTCTACCTTGTCCATGACAGGTA	9.20	9.13	8.19	AAGGTAAGT	11.00	15.48	12.19	12.71

#
## U2AF binding motif: combination of T, T, T, T, T/C, T/C/G    2014 NSMB; 
# Total of 58 motif sequences
# TTTTTT GTTTTT TGTTTT TTGTTT TTTGTT TTTTGT TTTTTG CTTTTT TCTTTT TTCTTT
# TTTCTT TTTTCT TTTTTC CCTTTT CTCTTT CTTCTT CTTTCT CTTTTC TCCTTT TCTCTT
# TCTTCT TCTTTC TTCCTT TTCTCT TTCTTC TTTCCT TTTCTC TTTTCC CGTTTT CTGTTT
# CTTGTT CTTTGT CTTTTG TCGTTT TCTGTT TCTTGT TCTTTG TTCGTT TTCTGT TTCTTG
# TTTCGT TTTCTG TTTTCG GCTTTT GTCTTT GTTCTT GTTTCT GTTTTC TGCTTT TGTCTT
# TGTTCT TGTTTC TTGCTT TTGTCT TTGTTC TTTGCT TTTGTC TTTTGC

# Ptbp2 binding motif: 2012 GD; 2017 Cell Report;
# CUCU, UCUC, UCUG, UUCU, CUGU
# UUUC, CUGG, UGUG, UCUU, CUGA
open(INA,"Result/07_predict/Merged_RSsites_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/Merged_Hs6st3_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");
open(INC,"Result/07_predict/Merged_RSintrons_nonRS_percent_3SS_5SS.xls")||die("Can't open INA:$!\n");

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
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t([ATCG]+)\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $a1++; $up20=$3; $percent_tc=$4; $percent_t=$5; $score3SS=$6; 
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT")) # U1 snRNA
  {
   if(($up20=~/TTTTTT/) or ($up20=~/GTTTTT/) or ($up20=~/TGTTTT/) or ($up20=~/TTGTTT/) or ($up20=~/TTTGTT/) or 
      ($up20=~/TTTTGT/) or ($up20=~/TTTTTG/) or ($up20=~/CTTTTT/) or ($up20=~/TCTTTT/) or ($up20=~/TTCTTT/) or
      ($up20=~/TTTCTT/) or ($up20=~/TTTTCT/) or ($up20=~/TTTTTC/) or ($up20=~/CCTTTT/) or ($up20=~/CTCTTT/) or
      ($up20=~/CTTCTT/) or ($up20=~/CTTTCT/) or ($up20=~/CTTTTC/) or ($up20=~/TCCTTT/) or ($up20=~/TCTCTT/) or
      ($up20=~/TCTTCT/) or ($up20=~/TCTTTC/) or ($up20=~/TTCCTT/) or ($up20=~/TTCTCT/) or ($up20=~/TTCTTC/) or
      ($up20=~/TTTCCT/) or ($up20=~/TTTCTC/) or ($up20=~/TTTTCC/) or ($up20=~/CGTTTT/) or ($up20=~/CTGTTT/) or
      ($up20=~/CTTGTT/) or ($up20=~/CTTTGT/) or ($up20=~/CTTTTG/) or ($up20=~/TCGTTT/) or ($up20=~/TCTGTT/) or
      ($up20=~/TCTTGT/) or ($up20=~/TCTTTG/) or ($up20=~/TTCGTT/) or ($up20=~/TTCTGT/) or ($up20=~/TTCTTG/) or
      ($up20=~/TTTCGT/) or ($up20=~/TTTCTG/) or ($up20=~/TTTTCG/) or ($up20=~/GCTTTT/) or ($up20=~/GTCTTT/) or
      ($up20=~/GTTCTT/) or ($up20=~/GTTTCT/) or ($up20=~/GTTTTC/) or ($up20=~/TGCTTT/) or ($up20=~/TGTCTT/) or
      ($up20=~/TGTTCT/) or ($up20=~/TGTTTC/) or ($up20=~/TTGCTT/) or ($up20=~/TTGTCT/) or ($up20=~/TTGTTC/) or
      ($up20=~/TTTGCT/) or ($up20=~/TTTGTC/) or ($up20=~/TTTTGC/) ) ## U2AF motifs
   {
    if(($up20=~/CTCT/) or ($up20=~/TCTC/) or ($up20=~/TCTG/) or ($up20=~/TTCT/) or ($up20=~/CTGT/) or 
       ($up20=~/TTTC/) or ($up20=~/CTGG/) or ($up20=~/TGTG/) or ($up20=~/TCTT/) or ($up20=~/CTGA/)) # Ptbp2 motif
    {
     if(($percent_tc >= $tc1) and ($percent_t >= $t1) and ($score3SS >= $ss3)){$a2++; print "RSsite:  $_\n";}
    }
   }
  }
 }
 else{print "error1\t$_\n";}
}


while(<INB>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t([ATCG]+)\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $b1++; $up20=$3; $percent_tc=$4; $percent_t=$5; $score3SS=$6;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT")) # U1 snRNA
  {
   if(($up20=~/TTTTTT/) or ($up20=~/GTTTTT/) or ($up20=~/TGTTTT/) or ($up20=~/TTGTTT/) or ($up20=~/TTTGTT/) or
      ($up20=~/TTTTGT/) or ($up20=~/TTTTTG/) or ($up20=~/CTTTTT/) or ($up20=~/TCTTTT/) or ($up20=~/TTCTTT/) or
      ($up20=~/TTTCTT/) or ($up20=~/TTTTCT/) or ($up20=~/TTTTTC/) or ($up20=~/CCTTTT/) or ($up20=~/CTCTTT/) or
      ($up20=~/CTTCTT/) or ($up20=~/CTTTCT/) or ($up20=~/CTTTTC/) or ($up20=~/TCCTTT/) or ($up20=~/TCTCTT/) or
      ($up20=~/TCTTCT/) or ($up20=~/TCTTTC/) or ($up20=~/TTCCTT/) or ($up20=~/TTCTCT/) or ($up20=~/TTCTTC/) or
      ($up20=~/TTTCCT/) or ($up20=~/TTTCTC/) or ($up20=~/TTTTCC/) or ($up20=~/CGTTTT/) or ($up20=~/CTGTTT/) or
      ($up20=~/CTTGTT/) or ($up20=~/CTTTGT/) or ($up20=~/CTTTTG/) or ($up20=~/TCGTTT/) or ($up20=~/TCTGTT/) or
      ($up20=~/TCTTGT/) or ($up20=~/TCTTTG/) or ($up20=~/TTCGTT/) or ($up20=~/TTCTGT/) or ($up20=~/TTCTTG/) or
      ($up20=~/TTTCGT/) or ($up20=~/TTTCTG/) or ($up20=~/TTTTCG/) or ($up20=~/GCTTTT/) or ($up20=~/GTCTTT/) or
      ($up20=~/GTTCTT/) or ($up20=~/GTTTCT/) or ($up20=~/GTTTTC/) or ($up20=~/TGCTTT/) or ($up20=~/TGTCTT/) or
      ($up20=~/TGTTCT/) or ($up20=~/TGTTTC/) or ($up20=~/TTGCTT/) or ($up20=~/TTGTCT/) or ($up20=~/TTGTTC/) or
      ($up20=~/TTTGCT/) or ($up20=~/TTTGTC/) or ($up20=~/TTTTGC/) ) ## U2AF motifs
   {
    if(($up20=~/CTCT/) or ($up20=~/TCTC/) or ($up20=~/TCTG/) or ($up20=~/TTCT/) or ($up20=~/CTGT/) or 
       ($up20=~/TTTC/) or ($up20=~/CTGG/) or ($up20=~/TGTG/) or ($up20=~/TCTT/) or ($up20=~/CTGA/)) # Ptbp2 motif
    {
     if(($percent_tc >= $tc1) and ($percent_t >= $t1) and ($score3SS >= $ss3) ){$b2++; print "Hs6st3:  $_\n";}
    }
   }
  }
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^(chr[\w\:\-\+]+)\t([ATCG]+)\t([ATCG]+)\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[ATCG]+\t([\d\.\-]+)\t[\d\.\-]+\t[\d\.\-]+\t[\d\.\-]+\s*$/)
 {
  $c1++; $up20=$3; $percent_tc=$4; $percent_t=$5; $score3SS=$6;
  if(($2 eq "AGGTAAGT") or ($2 eq "AGGTAAGG") or ($2 eq "AGGTAAGC") or ($2 eq "AGGTGAGT")) # U1 snRNA
  {
   if(($up20=~/TTTTTT/) or ($up20=~/GTTTTT/) or ($up20=~/TGTTTT/) or ($up20=~/TTGTTT/) or ($up20=~/TTTGTT/) or
      ($up20=~/TTTTGT/) or ($up20=~/TTTTTG/) or ($up20=~/CTTTTT/) or ($up20=~/TCTTTT/) or ($up20=~/TTCTTT/) or
      ($up20=~/TTTCTT/) or ($up20=~/TTTTCT/) or ($up20=~/TTTTTC/) or ($up20=~/CCTTTT/) or ($up20=~/CTCTTT/) or
      ($up20=~/CTTCTT/) or ($up20=~/CTTTCT/) or ($up20=~/CTTTTC/) or ($up20=~/TCCTTT/) or ($up20=~/TCTCTT/) or
      ($up20=~/TCTTCT/) or ($up20=~/TCTTTC/) or ($up20=~/TTCCTT/) or ($up20=~/TTCTCT/) or ($up20=~/TTCTTC/) or
      ($up20=~/TTTCCT/) or ($up20=~/TTTCTC/) or ($up20=~/TTTTCC/) or ($up20=~/CGTTTT/) or ($up20=~/CTGTTT/) or
      ($up20=~/CTTGTT/) or ($up20=~/CTTTGT/) or ($up20=~/CTTTTG/) or ($up20=~/TCGTTT/) or ($up20=~/TCTGTT/) or
      ($up20=~/TCTTGT/) or ($up20=~/TCTTTG/) or ($up20=~/TTCGTT/) or ($up20=~/TTCTGT/) or ($up20=~/TTCTTG/) or
      ($up20=~/TTTCGT/) or ($up20=~/TTTCTG/) or ($up20=~/TTTTCG/) or ($up20=~/GCTTTT/) or ($up20=~/GTCTTT/) or
      ($up20=~/GTTCTT/) or ($up20=~/GTTTCT/) or ($up20=~/GTTTTC/) or ($up20=~/TGCTTT/) or ($up20=~/TGTCTT/) or
      ($up20=~/TGTTCT/) or ($up20=~/TGTTTC/) or ($up20=~/TTGCTT/) or ($up20=~/TTGTCT/) or ($up20=~/TTGTTC/) or
      ($up20=~/TTTGCT/) or ($up20=~/TTTGTC/) or ($up20=~/TTTTGC/) ) ## U2AF motifs
   {
    if(($up20=~/CTCT/) or ($up20=~/TCTC/) or ($up20=~/TCTG/) or ($up20=~/TTCT/) or ($up20=~/CTGT/) or 
       ($up20=~/TTTC/) or ($up20=~/CTGG/) or ($up20=~/TGTG/) or ($up20=~/TCTT/) or ($up20=~/CTGA/)) # Ptbp2 motif
    {
     if(($percent_tc >= $tc1) and ($percent_t >= $t1) and ($score3SS >= $ss3) ){$c2++; print "RSintron:  $_\n";} 
    }
   }
  }
 }
 else{print "error3\t$_\n";}
}

print "%TC:$tc1   %T:$t1   3SS:$ss3  \n";
print "RSsites : $a1\t $a2\n";
print "Hs6st3  : $b1\t $b2\n";
print "RSintron: $c1\t $c2\n";

