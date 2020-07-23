#! /usr/local/perl -w

# Intron-length: 729766	AGGT-sites: 2641
### 14_+_119537648_ENSMUSG00000053465_Hs6st3	731475	chr14:119139119-119868885:ENSMUSG00000053465_Hs6st3_intron1
open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(OUT,">Result/05_motif/Hs6st3_intron1_40AGGT20.txt")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^>(\w\w?)\s+dna:/){$chr="chr$1";}
 elsif(/^[ATCGN]+$/){$seq{$chr}.=$_;}
 else{print "error1\t$_\n";}
}

# 14_+_119537648_ENSMUSG00000053465_Hs6st3	731475	chr14:119139119-119868885:ENSMUSG00000053465_Hs6st3_intron1
$intron=substr($seq{"chr14"},119139119, 119868885-119139119); 

my $a1=0;
while($intron=~/AGGT/g)
{
 $loci=length($`)+119139119+1; ## location 1-based
 $left=($loci-119139119-1)-40; ## substr 0-based
 $motif=substr($intron, $left, 64); ## 40 + AGGT + 20
 print OUT "chr14:$loci:Hs6st3\t$motif\n";
 $a1++;
}

$len=length($intron);
print "Intron-length: $len\tAGGT-sites: $a1\n";

close INA; close OUT;

