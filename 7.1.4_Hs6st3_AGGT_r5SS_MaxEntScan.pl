#! /usr/local/perl -w

open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/Hs6st3_nonRS_18AGGT1.fa")||die("Can't open INB:$!\n");
open(OUT,">Result/07_predict/Hs6st3_nonRS_r5SS_3upGT4.fa")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^>(\w\w?)\s+dna:/){$chr="chr$1";}
 elsif(/^[ATCGN]+$/){$seq{$chr}.=$_;}
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^>(chr\w\w?)\:(\d+)\:\w+\s*$/)
 {
  $a1++;
  $seq3=substr($seq{$1},$2+2-1,6); ## start from GT, not AGGT, +2
  print OUT "$_\nCAG$seq3\n"; ## CAG fron upstream exon
 }
}

print "nonRS AGGT-sites: $a1\n";

close INA; close INB;
close OUT;

