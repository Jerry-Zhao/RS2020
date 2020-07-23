#! /usr/local/perl -w

##

# cp RSintrons_18AGGT1.fa RSintrons_nonRS_18AGGT1.fa
# Manually remove 20 RS sites from: RSintrons_nonRS_18AGGT1.fa

open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/RSintron_0522.txt")||die("Can't open INA:$!\n");
open(OUT,">Result/07_predict/RSintrons_18AGGT1.fa")||die("Can't write OUT:$!\n");

while(<INA>){chomp;if(/^>(\w\w?)\s+dna:/){$chr="chr$1";}elsif(/^[ATCGN]+$/){$genome{$chr}.=$_;}else{print "error1\t$_\n";}}
while(<INB>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+)\_intron\:([+|-])$/)
 {       
  if($5 eq "+"){$intron=substr($genome{$1}, $2-1, $3-$2+1);}
  elsif($5 eq "-"){$intron_r=substr($genome{$1}, $2-1, $3-$2+1); $intron=reverse $intron_r; $intron=~tr/ATCG/TAGC/;}
  else{print "error strand $_\n";}

  $chr=$1; $left_intron=$2; $right_intron=$3; $gene=$4; $strand=$5; $line=$_; 
  $a1=0;
  while($intron=~/AGGT/g)
  {
   $loci=length($`)+1; ## location 1-based
   $left=($loci-1)-18; ## substr 0-based
   if($left>=18)
   {
    $motif=substr($intron, $left, 23); ## 18 + AGGT + 1

    if($strand eq "+"){$location = $left_intron + $loci -1;} ## location in genome
    elsif($strand eq "-"){$location = $right_intron - $loci +1 -1;} ## location in genome
    else{print "error strand $_\n";}

    print OUT ">$chr:$location\_$gene\n$motif\n";
    $a1++;
   }
  }
 
  $len=length($intron); print "$line\tIntron-length: $len\tAGGT-sites: $a1\n";
 }
 else{print "error2\t$_\n";}
}
close INA; close INB; close OUT;
