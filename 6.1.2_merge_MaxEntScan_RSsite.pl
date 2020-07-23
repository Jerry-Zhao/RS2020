#! /usr/local/perl -w
#
open(INA,"Result/06_RSexon/RS_sites_3end_MaxEntScan_score.txt")||die("Can't open INA:$!\n");
open(INB,"Result/06_RSexon/RS_sites_re5SS_MaxEntScan_score.txt")||die("Can't open INB:$!\n");
open(OUT,">Result/06_RSexon/RS_sites_MaxEntScan_score_merged.xls")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^>(chr\w\w?\_[+|-]\_\d+\_\w+)\_intron\d+\s*$/){$id=$1;}
 elsif(/^([ATCG]+)\s+MAXENT:\s+([\w\.\-]+)\s+MDD:\s+([\w\.\-]+)\s+MM:\s+([\w\.\-]+)\s+WMM:\s+([\w\.\-]+)\s*$/)
 {$end3{$id}="$1\t$2\t$3\t$4\t$5";}
 else{print "error1 3end; $_\n";}
}

print OUT "\tMotif5\tMAXENT5\tMDD5\tMM5\tWMM5\tMotif3\tMAXENT3\tMDD3\tMM3\tWMM3\n";
while(<INB>)
{
 chomp;
 if(/^>(chr\w\w?\_[+|-]\_\d+\_\w+)\s*$/){$id2=$1;}
 elsif(/^([ATCG]+)\tMAXENT:\s+([\w\.\-]+)\tMDD:\s+([\w\.\-]+)\tMM:\s+([\w\.\-]+)\tWMM:\s+([\w\.\-]+)\s*$/)
 {
  print OUT "$id2\t$1\t$2\t$3\t$4\t$5\t$end3{$id2}\n";
 }
 else{print "error2 5end; $_\n";}
}

