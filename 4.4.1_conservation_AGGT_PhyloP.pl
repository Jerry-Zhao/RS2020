#! /usr/local/perl -w
#
#
# http://hgdownload.cse.ucsc.edu/goldenpath/mm10/phyloP60way/
# PhyloP scores in bigWig format files:
#    mm10.60way.phyloP60way.bw
#    mm10.60way.phyloP60wayPlacental.bw
# PhyloP scores in fixed step wiggle format:
#    mm10.60way.phyloP60way/*.wigFix.gz - phyloP scores for all 60 species
#    placental/*.wigFix.gz - phyloP scores for the placental subset
#
#
open(INAA,"Result/RS_site_0522.txt")||die("Can't open INAA:$!\n");
open(INA,"/media/Project/Genome/phyloP/mm10_phyloP60way.txt")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Genome/phyloP/mm10_phyloP60way.placental.txt")||die("Can't open INB:$!\n");
open(INC,"Result/RS_site_0522.txt")||die("Can't open INC:$!\n");

open(OUA,">Result/04_RS_intron/RSsite_phyloP_300updown.xls")||die("Can't write OUA:$!\n");
open(OUB,">Result/04_RS_intron/RSsite_phyloP_Placental_300updown.xls")||die("Can't write OUB:$!\n");

print "Working on File 1 of file 4\n";
while(<INAA>)
{
 chomp;
 if(/^chr(\w\w?)\_([+|-])\_(\d+)\s+([\w\.]+)$/)
 {
  $chr=$1; $strand=$2; $loci=$3;
  if($strand eq "+") ## gene on + strand
  {
   for($i=$loci-300;$i<$loci+304; $i++)
   {
    $id2="$chr\_$i"; $all{$id2}=0; $placenta{$id2}=0; ## initial the HASH
   }
  }
  elsif($strand eq "-") ## gene on - strand
  {
   for($i=$loci+1+300;$i>$loci-2-301; $i--)
   {
    $id2="$chr\_$i"; $all{$id2}=0; $placenta{$id2}=0; ## initial the HASH
   }
  }
  else{print "error strand $_\n";}
 }
 else{print "errorAA\t$_\n";}
}


print "Working on File 2 of file 4\n";
while(<INA>)
{
 chomp;
 if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2"; if(exists $all{$id}){$all{$id}=$3;}}
 else{print "error1\t$_\n";}
}

print "Working on File 3 of file 4\n";
while(<INB>)
{
 chomp;
 if(/^(\w\w?)\t(\d+)\t([\d\.\-]+)$/){$id="$1_$2";if(exists $placenta{$id}){$placenta{$id}=$3;}}
 else{print "error2\t$_\n";}
}

print "Working on File 4 of file 4\n";
while(<INC>)
{
 chomp;
 if(/^chr(\w\w?)\_([+|-])\_(\d+)\s+([\w\.]+)$/)
 {
  print OUA "chr$1_$2_$3_$4"; print OUB "chr$1_$2_$3_$4";
  $chr=$1; $strand=$2; $loci=$3;

  if($strand eq "+") ## gene on + strand
  {
   for($i=$loci-300;$i<$loci+304; $i++)
   {
    $id3="$chr\_$i"; print OUA "\t$all{$id3}"; print OUB "\t$placenta{$id3}";
   }
  }
  elsif($strand eq "-") ## gene on - strand
  {
   for($i=$loci+1+300;$i>$loci-2-301; $i--)
   {
    $id3="$chr\_$i"; print OUA "\t$all{$id3}"; print OUB "\t$placenta{$id3}";
   }
  }
  else{print "error strand $_\n";}

  print OUA "\n"; print OUB "\n";
 }
 else{print "error3\t$_\n";}
}

close INA; close INB; close INC; close INAA;
close OUA; close OUB;

