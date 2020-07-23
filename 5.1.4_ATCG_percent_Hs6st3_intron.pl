#! /usr/local/perl -w
#
#
open(INA,"Result/05_motif/Hs6st3_intron1_40AGGT20.txt")||die("Can't open INA:$!\n");
open(OUA,">Result/05_motif/Hs6st3_intron1_20up_ATCG.xls")||die("Can't write OUT:$!\n");
open(OUB,">Result/05_motif/Hs6st3_intron1_20up_percent.xls")||die("Can't write OUT:$!\n");

my $a1=0;
print OUA "NT\tPercent\n";
print OUB "Seq\tMotif\tPercent_TC\tPercent_T\tPercent_C\tPercent_G\tPercent_A\n";
while(<INA>)
{
 chomp;
 if(/^chr\w\w?\:\d+\:\w+\s+[ATCG]{20}([ATCG]{20})(AGGT[ATCG]{4})[ATCG]{16}$/)
 {
  $seq=$1; $a1++;

  ## count the number of A T C G
  $counta=$countt=$countc=$countg=0;

  $counta = ($seq=~ tr/A/N/);
  $countt = ($seq=~ tr/T/N/);
  $countc = ($seq=~ tr/C/N/);
  $countg = ($seq=~ tr/G/N/);

  # percentages 
  $ratioa = int(1000*$counta/20)/1000; 
  $ratiot = int(1000*$countt/20)/1000;
  $ratioc = int(1000*$countc/20)/1000;
  $ratiog = int(1000*$countg/20)/1000;
  
  # Percentages T+C, A+G
  $ratiotc = $ratiot + $ratioc;
  $ratioag = $ratioa + $ratiog;

  print OUA "A\t$ratioa\nT\t$ratiot\nC\t$ratioc\nG\t$ratiog\nTC\t$ratiotc\nAG\t$ratioag\n";
  print OUB "$_\t$2\t$ratiotc\t$ratiot\t$ratioc\t$ratiog\t$ratioa\n";
 }
 else{print "error1\t$_\n";}
}

print "Total-RS-sites: $a1\n";

close INA; close OUA; close OUB;

