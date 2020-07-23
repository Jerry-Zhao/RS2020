#! /usr/local/perl -w
#
#
open(INA,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM.xls")||die("Can't open INA:$!\n");
open(INB,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_raw.xls")||die("Can't open INB:$!\n");
open(INC,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM.xls")||die("Can't open INC:$!\n");

open(OUA,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_0.xls");

while(<INA>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(($4+$5+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16)>0){$nuclear{$1}=1;$a1++;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(exists $nuclear{$1}){$nuclear{$1}="$3\t$4\t$5\t$6\t$7\t$8\t$9\t$10\t$11\t$12\t$13\t$14\t$15\t$16";}
 }
 else{print "error2\t$_\n";}
}

while(<INC>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(($4+$5+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16)>0){print OUA "$_\t$nuclear{$1}\n";} ## total RPM >0  
 }
 else{print "error1\t$_\n"; print OUA "$_\n";}
}

print "Nuclear>0: $a1\n";


