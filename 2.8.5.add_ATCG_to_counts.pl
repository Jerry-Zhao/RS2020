#! /usr/local/perl -w
# Add ATCG sequence to the junction counts
#
#
open(IN,"/media/Project/Genome/Mus_musculus.GRCm38.93.mm10.fa")||die("Can't open IN:$!\n");

open(INA,"Junctions/Junction_reads_AG_count_merged_raw.xls")||die("Can't open INA:$!\n");
open(INB,"Junctions/Junction_reads_AG_count_merged_RPM.xls")||die("Can't open INB:$!\n");

open(OUA,">Junctions/Junction_reads_AGNN_count_merged_raw.xls")||die("Can't write OUA:$!\n");
open(OUB,">Junctions/Junction_reads_AGNN_count_merged_RPM.xls")||die("Can't write OUB:$!\n");


while(<IN>)
{
 chomp;
 if(/^\>(\w\w?)\s+dna/)
 {
  $id="$1";
 }
 elsif(/^[ATCGNNnatcgn]+$/)
 {
  $seq{$id}.=$_;
 }
 else{print "error1\t$_\n";}
}

while(<INA>)
{
 chomp;
 if(/^(\w\w?)\_([+|-])\_(\d+)\_/)
 {
  print OUA "$_\t";
  
  if($2 eq '+'){$motif=substr($seq{$1},$3-1,4);}
  elsif($2 eq '-'){$motif_r=substr($seq{$1},$3-2-1,4); $motif=reverse($motif_r); $motif=~tr/atcgATCG/tagcTAGC/;}
  else{print "error strand: $_\n";}
  print OUA "$motif\n";
 }
 else{print OUA "$_\tMotif\n"; print "error-raw: $_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?)\_([+|-])\_(\d+)\_/)
 {
  print OUB "$_\t";

  if($2 eq '+'){$motif=substr($seq{$1},$3-1,4);}
  elsif($2 eq '-'){$motif_r=substr($seq{$1},$3-2-1,4); $motif=reverse($motif_r); $motif=~tr/atcgATCG/tagcTAGC/;}
  else{print "error strand: $_\n";}
  print OUB "$motif\n";
 }
 else{print OUB "$_\tMotif\n"; print "error-RPM: $_\n";}
}






