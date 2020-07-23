#! /usr/local/perl -w
#
#
open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/RS_exon_0522.txt")||die("Can't open INB:$!\n");

open(OUA,">Result/05_motif/RSexon_5end_40up20down.txt")||die("Can't write OUA;$!\n");
open(OUB,">Result/05_motif/RSexon_3end_40up20down.txt")||die("Can't write OUB;$!\n");

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
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:([+|-])\t([ATCG-]+)$/)
 {
  $id="$1:$2-$3:$4:$5";
  if($4 eq "+") ## + strand
  {
   $seq_5end=substr($seq{$1}, $2-40-1-2, 64); ## 40nt + AGGT + 20nt
   $seq_3end=substr($seq{$1}, $3-40-1-1, 64); ## 40nt + ##GT + 20nt
   print OUA "$id\t$seq_5end\n";
   print OUB "$id\t$seq_3end\n";
  }
  elsif($4 eq "-") ## - strand
  {
   $seq_5end_r=substr($seq{$1}, $3-20-1-1, 64); ## 40nt + AGGT + 20nt
   $seq_5end=reverse $seq_5end_r; $seq_5end=~tr/ATCG/TAGC/; ## Reverse, complementary

   $seq_3end_r=substr($seq{$1}, $2-20-1-2, 64); ## 40nt + AGGT + 20nt
   $seq_3end=reverse $seq_3end_r; $seq_3end=~tr/ATCG/TAGC/; ## Reverse, complementary

   print OUA "$id\t$seq_5end\n";
   print OUB "$id\t$seq_3end\n";
  }
  else{print "error strand $_\n";}
 }
 else{print "error1\t$_\n";}
}

close INA; close INB; close OUA; close OUB;
