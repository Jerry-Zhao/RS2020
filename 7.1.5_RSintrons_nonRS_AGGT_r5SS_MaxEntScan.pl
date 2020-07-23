#! /usr/local/perl -w

open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/07_predict/RSintrons_nonRS_18AGGT1.fa")||die("Can't open INB:$!\n");
open(OUT,">Result/07_predict/RSintrons_nonRS_r5SS_3upGT4.fa")||die("Can't write OUT:$!\n");

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
 if(/^>(chr\w\w?):(\d+)\_ENSMUSG\d+\_(\w+)\s*$/)
 {
  $a1++;
  $strand=''; $seq5='';
  if($3 eq "Ntm"){$strand="-"; $seq5="AAG";}
  if($3 eq "Opcml"){$strand="+"; $seq5="CAG";}
  if($3 eq "Cadm2"){$strand="-"; $seq5="AAG";}
  if($3 eq "Ank3"){$strand="+"; $seq5="AAG";}
  if($3 eq "Hs6st3"){$strand="+"; $seq5="CAG";}

  if($3 eq "Ncam1"){$strand="-"; $seq5="CAG";}
  if($3 eq "Pde4d"){$strand="+"; $seq5="ACG";}
  if($3 eq "Robo2"){$strand="-"; $seq5="CAT";}
  if($3 eq "Cadm1"){$strand="+"; $seq5="CAG";}
  if($3 eq "Lsamp")
  {
   $strand="+"; 
   if($2< 40786000){$seq5="AAG";} ## intron 1
   if($2> 40786061){$seq5="CAG";} ## intron 2
  }

  if($3 eq "Kcnip1"){$strand="-"; $seq5="AAG";}
  if($3 eq "Cdh4"){$strand="+"; $seq5="AAG";}
  if($3 eq "Hs6st2"){$strand="-"; $seq5="CAG";}

  if($strand eq "+"){$seq3=substr($seq{$1},$2+2-1,6);} ## start from GT, not AGGT, +2
  elsif($strand eq "-"){$seq3_r=substr($seq{$1},$2-6-1,6); $seq3=reverse $seq3_r; $seq3=~tr/ATCG/TAGC/;}
  else{print "error strand $_\n";}

  print OUT "$_\n$seq5$seq3\n"; ## $seq5 fron upstream exon
 }
 elsif(/^[ATCGN]+$/){}
 else{print "error $_\n";}
}

print "nonRS AGGT-sites: $a1\n";

close INA; close INB;
close OUT;

