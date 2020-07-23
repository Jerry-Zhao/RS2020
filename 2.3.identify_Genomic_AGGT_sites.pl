#! /usr/local/perl -w


open(INA, "/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa");
open(OUT,">Junctions/RS_sites_mm10.xls")||die("Can't write OUT:$!\n");
#Total RS-sites: + 10200931	- 10202316	Total 20403247

#open(INA, "/media/Project/Genome/Homo_sapiens.GRCh38.93.hg38.fa");
#open(OUT,">Junctions/RS_sites_hg38.xls")||die("Can't write OUT:$!\n");
#Total RS-sites: + 11483389	- 11582163	Total 23065552

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
# $chrseq_r=reverse $chrseq; $chrseq_r=~tr/ATCG/TAGC/;

 ## + strand 
 $start_loci=0;
 $loci=index($chrseq, "AGGT", $start_loci) + 1; ## index start from 0-based, chromosome 1-based 
 while($loci != 0) ## no match $loci=-1;
 {
  $a1++;
  print OUT "$key1\t+\t$loci\n";
  $start_loci = $loci + 1;
  $loci = index($chrseq, "AGGT", $start_loci) + 1;
 }

 ## - strand
 $start_loci=0; 
 $loci=index($chrseq, "ACCT", $start_loci) + 1; ## index start from 0-based, chromosome 1-based 
 while($loci != 0) ## no match $loci=-1;
 {
  $a2++;
  print OUT "$key1\t-\t$loci\n";
  $start_loci = $loci + 1;
  $loci = index($chrseq, "ACCT", $start_loci) + 1;
 }
}

$a3=$a1+$a2;
print "Total RS-sites: + $a1\t- $a2\tTotal $a3\n";

