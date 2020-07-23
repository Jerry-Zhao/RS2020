#! /usr/local/perl -w
print "Please enter the sample name: GSE83474_Male6wWT_exc_nuRNA_rep1 \n";
chomp($inputname=<STDIN>);

open(INA,"count/bin/$inputname\_10kbIntron_1000bin.txt")||die("Can't open INA:$!\n");
open(OUA,">Result/03_ML/$inputname\_intronSlop.xls")||die("Can't write OUA:$!\n");
open(OUB,">Result/03_ML/$inputname\_intronSlop_percent.xls")||die("Can't write OUA:$!\n");

while(<INA>)
{
 chomp;
 if(/^(chr\w\w?\:)(\d+)\-(\d+)([\w\.\-\(\)\:\+\-]+\_intron\d+)\:(\d+)\t(\d+)$/)
 {
  $a1++;
  $id="$1$2-$3$4";
  $length{$id}=$3-$2+1; ## length of intron
  if(exists $total{$id}){$total{$id}+=$6;}else{$total{$id}=$6;}  ## total reads in this intron
  
  $id_bin="bin$5";
  if(exists $$id_bin{$id}){print "error exists $_\n";}else{$$id_bin{$id}=$6;}

 }
 else{print "error1\t$_\n";}
}

print OUA "\tLength"; print OUB "\tLength";
for($m=0;$m<1000;$m++){print OUA "\tBin$m"; print OUB "\tBin$m";}
print OUA "\n"; print OUB "\n";

foreach $intron (keys %total)
{
 $a2++;
 
 #### Raw reads
 print OUA "$intron\t$length{$intron}";
 for($i=0;$i<1000;$i++)
 {
  $bin_id="bin$i";
  print OUA "\t$$bin_id{$intron}";
 }
 print OUA "\n";


 #### normalized to total reads in that intron, percentage 
 if($total{$intron} >100) ## total reads in this intron >100
 {
  $a3++;
  print OUB "$intron\t$length{$intron}";
  for($i=0;$i<1000;$i++)
  {
   $bin_id="bin$i";
   $count=$$bin_id{$intron} / $total{$intron}; ## round, two significant number
   print OUB "\t$count";
  }
  print OUB "\n";
 }
}

print "Total-bins: $a1\tTotal-intron: $a2\tResult-intron: $a3\n";

close INA; 
close OUA; close OUB;

