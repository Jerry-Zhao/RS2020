#! /usr/local/perl -w


open(INA, "/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa");
open(OUT,">Junctions/RSAG_sites_mm10.xls")||die("Can't write OUT:$!\n");
# Total RSAG-sites: + 194,223,537	- 194,358,528	Total 388,582,065

#open(INA, "/media/Project/Genome/Homo_sapiens.GRCh38.93.hg38.fa");
#open(OUT,">Junctions/RSAG_sites_hg38.xls")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^>(\w\w?)\s+dna\:/)
 {
  $id="chr$1";
  if(exists $seq{$id}){print "error exists Chr name: $_\n";}
 }
 elsif(/^[ATCGNatcgn]+$/)
 {
  $seqtmp=$_;
  $seqtmp=~tr/atcgn/ATCGN/;
  $seq{$id}.=$seqtmp;
 }
 else{print "error1\t$_\n";}
}

my $a1=$a2=0;
foreach $key1 (keys %seq)
{
 $chrseq=$seq{$key1};

 ## + strand 
 $start_loci=0;
 $loci=index($chrseq, "AG", $start_loci) + 1; ## index start from 0-based, chromosome 1-based 
 while($loci != 0) ## no match $loci=-1;
 {
  $a1++;
  print OUT "$key1\t+\t$loci\n";
  $start_loci = $loci + 1;
  $loci = index($chrseq, "AG", $start_loci) + 1;
 }

 ## - strand
 $start_loci=0; 
 $loci=index($chrseq, "CT", $start_loci) + 1; ## index start from 0-based, chromosome 1-based 
 while($loci != 0) ## no match $loci=-1;
 {
  $a2++;
  print OUT "$key1\t-\t$loci\n";
  $start_loci = $loci + 1;
  $loci = index($chrseq, "CT", $start_loci) + 1;
 }
}

$a3=$a1+$a2;
print "Total RSAG-sites: + $a1\t- $a2\tTotal $a3\n";

