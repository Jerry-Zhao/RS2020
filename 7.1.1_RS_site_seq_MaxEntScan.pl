#! /usr/local/perl -w
#
open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/RS_site_0522.txt")||die("Can't open INB:$!\n");

open(OUT,">Result/07_predict/RS_sites_18AGGT1.fa")||die("Can't write OUT;$!\n");

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
 if(/^(chr\w\w?)\_([+|-])\_(\d+)\s+(\w+)\.(\d)\s*$/)
 {
  $id="$1_$2_$3_$4_intron$5";
  if($2 eq "+") ## + strand
  {
   $left=$3-18-1; 
   $seq_motif=substr($seq{$1}, $left, 23); ## 18nt + AGGT + 1nt
   print OUT ">$id\n$seq_motif\n";
  }
  elsif($2 eq "-") ## - strand
  {
   $left=$3-1-1; 
   $seq_motif_r=substr($seq{$1}, $left, 23); ## 18nt + AGGT + 1nt
   $seq_motif=reverse $seq_motif_r; $seq_motif=~tr/ATCG/TAGC/; ## Reverse, complementary
   print OUT ">$id\n$seq_motif\n";
  }
  else{print "error strand $_\n";}
 }
 else{print "error1\t$_\n";}
}


close INA; close INB; close OUT;



