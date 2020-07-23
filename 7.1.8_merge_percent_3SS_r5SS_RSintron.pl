#! /usr/local/perl -w
#
open(INA,"Result/05_motif/RSintrons_nonRS_20up_percent.xls")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/RSintrons_nonRS_18AGGT1_MaxEntScan_score.txt")||die("Can't open INB:$!\n");
open(INC,"Result/07_predict/RSintrons_nonRS_r5SS_3upGT4_MaxEntScan_score.txt")||die("Can't open INC:$!\n");
open(OUT,">Result/07_predict/Merged_RSintrons_nonRS_percent_3SS_5SS.xls")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^(chr[\w\+\-\:]+)\t[ATCG]{20}([ATCG]{20})AGGT[ATCG]{20}\t([ATCG]{8})\t([\d\.\s]+)\s*$/)
 {
  if(exists $percent{$1}){print "error exists HASH-Percent: $_\n";}
  else{$percent{$1}="$3\t$2\t$4"; $a1++;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^>(chr[\w\+\-\:]+)\s*$/){$id3ss=$1; }
 elsif(/^([ATCG]{23})\s+MAXENT:\s+([\d\.\-]+)\s+MM:\s+([\d\.\-]+)\s+WMM:\s+([\d\.\-]+)\s*$/)
 {
  if(exists $ss3{$id3ss}){print "error exists HASH-3SS: $id3ss\n";}
  else{$ss3{$id3ss}="$1\t$2\t$3\t$4"; $a2++;}
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^>(chr[\w\+\-\:]+)\s*$/){$id5ss=$1;}
 elsif(/^([ATCG]{9})\s+MAXENT:\s+([\d\.\-]+)\s+MDD:\s+([\d\.\-]+)\s+MM:\s+([\d\.\-]+)\s+WMM:\s+([\d\.\-]+)\s*$/)
 {
  if(exists $ss5{$id5ss}){print "error exists HASH-5SS: $id5ss\n";}
  else{$ss5{$id5ss}="$1\t$2\t$3\t$4\t$5"; $a3++;}
 }
 else{print "error3\t$_\n";}
}

print OUT "\tMotif\tup20_seq\tup20_TC\tup20_T\tup20_C\tup20_G\tup20_A\t";
print OUT "SS3_seq\tSS3_MAXENT\tSS3_MM\tSS3_WMM\t";
print OUT "rSS5_seq\trSS5_MAXENT\trSS5_MDD\trSS5_MM\trSS5_WMM\n";
foreach (keys %percent)
{
 print OUT "$_\t$percent{$_}\t";
 if(exists $ss3{$_}){print OUT "$ss3{$_}\t";}else{print "error not exists 3SS: $_\n";}
 if(exists $ss5{$_}){print OUT "$ss5{$_}\n";}else{print "error not exists 5SS: $_\n";}
}

print "Total ID: $a1\t$a2\t$a3\n";

close INA; close INB; close INC;
close OUT;
