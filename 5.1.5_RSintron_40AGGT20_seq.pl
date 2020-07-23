#! /usr/local/perl -w

## Manually remove 
# chr9:29411641-29962844:ENSMUSG00000059974_Ntm_intron:-	Intron-length: 551204	AGGT-sites: 2183
# chr9:27791447-28404327:ENSMUSG00000062257_Opcml_intron:+	Intron-length: 612881	AGGT-sites: 2393
# chr16:66953301-67620170:ENSMUSG00000064115_Cadm2_intron:-	Intron-length: 666870	AGGT-sites: 2137
# chr10:69534285-69808415:ENSMUSG00000069601_Ank3_intron:+	Intron-length: 274131	AGGT-sites: 1070
# chr14:119139119-119868885:ENSMUSG00000053465_Hs6st3_intron:+	Intron-length: 729767	AGGT-sites: 2641
# chr9:49569901-49798677:ENSMUSG00000039542_Ncam1_intron:-	Intron-length: 228777	AGGT-sites: 876
# chr13:109117081-109740386:ENSMUSG00000021699_Pde4d_intron:+	Intron-length: 623306	AGGT-sites: 2169
# chr13:109442354-109740386:ENSMUSG00000021699_Pde4d_intron:+	Intron-length: 298033	AGGT-sites: 1008
# chr16:74046938-74352550:ENSMUSG00000052516_Robo2_intron:-	Intron-length: 305613	AGGT-sites: 998
# chr9:47530506-47787970:ENSMUSG00000032076_Cadm1_intron:+	Intron-length: 257465	AGGT-sites: 1026
# chr16:39984728-40786000:ENSMUSG00000061080_Lsamp_intron:+	Intron-length: 801273	AGGT-sites: 2707
# chr16:40786061-41533452:ENSMUSG00000061080_Lsamp_intron:+	Intron-length: 747392	AGGT-sites: 2575
# chr11:33651573-33843129:ENSMUSG00000053519_Kcnip1_intron:-	Intron-length: 191557	AGGT-sites: 743
# chr2:179444812-179780253:ENSMUSG00000000305_Cdh4_intron:+	Intron-length: 335442	AGGT-sites: 1427
# chrX:51471407-51679889:ENSMUSG00000062184_Hs6st2_intron:-	Intron-length: 208483	AGGT-sites: 765

# cp RSintrons_40AGGT20.txt RSintrons_40AGGT20_nonRS.txt
# Manually remove 20 RS sites from: RSintrons_40AGGT20_nonRS.txt

open(INA,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open INA:$!\n");
open(INB,"Result/RSintron_0522.txt")||die("Can't open INA:$!\n");
open(OUT,">Result/05_motif/RSintrons_40AGGT20.txt")||die("Can't write OUT:$!\n");

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
   $left=($loci-1)-40; ## substr 0-based
   if($left>=40)
   {
    $motif=substr($intron, $left, 64); ## 40 + AGGT + 20

    if($strand eq "+"){$location = $left_intron + $loci -1;} ## location in genome
    elsif($strand eq "-"){$location = $right_intron - $loci +1 -1;} ## location in genome
    else{print "error strand $_\n";}

    print OUT "$chr:$location\_$gene\t$motif\n";
    $a1++;
   }
  }
 
  $len=length($intron); print "$line\tIntron-length: $len\tAGGT-sites: $a1\n";
 }
 else{print "error2\t$_\n";}
}
close INA; close INB; close OUT;
