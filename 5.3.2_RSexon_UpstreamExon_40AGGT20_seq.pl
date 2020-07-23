#! /usr/local/perl -w
#
#
open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/06_RSexon/RSexon_upstream_exon.txt")||die("Can't open INB:$!\n");

open(OUA,">Result/06_RSexon/RSexon_upstreamExon_40up20down.txt")||die("Can't write OUA;$!\n");

while(<INA>)
{
 chomp;
 if(/^>(\w\w?)\s+dna:/)
 {
  $chr="chr$1";
 }
 elsif(/^[ATCGN]+$/)
 {
  $seq{$chr}.=$_;
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^chr\w\w?\:\d+\-\d+\:([+|-])\:[\w\-]+\:([\w\.]+)\t(chr\w\w?)\:(\d+)\-(\d+)$/)
 {
  $id="$3:$4-$5:$1:$2";
  if($1 eq "+") ## + strand
  {
   $seq_3end=substr($seq{$3}, $5-40-1-1, 64); ## 40nt + ##GT + 20nt
   print OUA "$id\t$seq_3end\n";
  }
  elsif($1 eq "-") ## - strand
  {
   $seq_3end_r=substr($seq{$3}, $4-20-1-2, 64); ## 40nt + AGGT + 20nt
   $seq_3end=reverse $seq_3end_r; $seq_3end=~tr/ATCG/TAGC/; ## Reverse, complementary

   print OUA "$id\t$seq_3end\n";
  }
  else{print "error strand $_\n";}
 }
 else{print "error1\t$_\n";}
}

close INA; close INB; close OUA;
