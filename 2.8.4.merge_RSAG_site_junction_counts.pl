#! /usr/local/perl -w


open(OUA,">Junctions/Junction_reads_AG_count_merged_raw.xls")||die("Can't write OUA:$!\n");
open(OUB,">Junctions/Junction_reads_AG_count_merged_RPM.xls")||die("Can't write OUB:$!\n");
 
open(IN,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf.gene")||die("Can't open INA:$!\n");
open(INTRONP,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.intron")||die("Can't open INTRON:$!\n");
open(INTRONM,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.intron")||die("Can't open INTRON:$!\n");
open(EXONP,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.exon")||die("Can't open EXON:$!\n");
open(EXONM,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.exon")||die("Can't open EXON:$!\n"); 
 
open(INRS,"Junctions/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");

open(IN01,"Junctions/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN02,"Junctions/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN03,"Junctions/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN04,"Junctions/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN05,"Junctions/GSE90205_GingerasLab_8w_Cortex_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN06,"Junctions/GSE90205_GingerasLab_8w_Cortex_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");

open(IN07,"Junctions/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN08,"Junctions/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN09,"Junctions/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN10,"Junctions/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN11,"Junctions/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN12,"Junctions/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN13,"Junctions/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN14,"Junctions/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4.junc_count_AG.txt")||die("Can't open INA:$!\n");

open(IN15,"Junctions/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1.junc_count_AG.txt")||die("Can't open INA:$!\n");
open(IN16,"Junctions/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2.junc_count_AG.txt")||die("Can't open INA:$!\n");


print "Working on Gene file.\n";
while(<IN>)
{
 chomp;
 if(/^(\w\w?)\t(\w+)\tgene\t(\d+)\t(\d+)\t([+|-])\t(ENSMUSG\d+)\t([\w\.\-\(\)]+)$/)
 {
  $TSS_id="$6_$7"; $glength{$TSS_id}=$4-$3+1;
 }
 else{print "error1\t$_\n";}
}

while(<INRS>)
{
 chomp;
 if(/^chr(\w\w?)\_([+|-])\_(\d+)\_ENSMUSG\d+\_[\w\.\-]+\t\d+$/)
 {
  if($2 eq "+"){$loci=$3+2;}elsif($2 eq "-"){$loci=$3-1;}else{print "error strand: $_\n";} ## minus, $3-1, diff from AGGT site count
  $lociid="$1_$loci"; $rssite{$lociid}=1;
#  print "$lociid:  $_\n";
 }
 else{print "error1\t$_\n";}
} 

print "Working on Intron file.\n";
while(<INTRONP>)
{
 chomp;
 if(/^chr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+\_intron\d+)\t\+$/)
 {
  $intronid="chr$1:$2-$3:$4"; $ilength{$intronid}=$3-$2+1;
  for($i=$2;$i<=$3;$i++)
  {
   $id="$1_$i"; if(exists $rssite{$id}){$intron{$id}=$intronid;}
  }
 }
 else{print "error intron plus:\t$_\n";}
}

print "Working on Intron file.\n";
while(<INTRONM>)
{
 chomp;
 if(/^chr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+\_intron\d+)\t\-$/)
 {
  $intronid="chr$1:$2-$3:$4"; $ilength{$intronid}=$3-$2+1;
  for($i=$2;$i<=$3;$i++)
  {
   $id="$1_$i";if(exists $rssite{$id}){$intron{$id}=$intronid;}
  }
 }
 else{print "error intron minus:\t$_\n";}
}

print "Working on Exon file.\n";
while(<EXONP>)
{
 chomp;
 if(/^chr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+\_exon\d+)\t\+$/)
 {
  $exonid="chr$1:$2-$3:$4"; $elength{$exonid}=$3-$2+1;
  for($i=$2;$i<=$3;$i++)
  {
   $id="$1_$i"; if(exists $rssite{$id}){$exon{$id}=$exonid;}
  }
 }
 else{print "error exon plus:\t$_\n";}
}

print "Working on Exon file.\n";
while(<EXONM>)
{
 chomp;
 if(/^chr(\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-]+\_exon\d+)\t\-$/)
 {
  $exonid="chr$1:$2-$3:$4"; $elength{$exonid}=$3-$2+1;
  for($i=$2;$i<=$3;$i++)
  {
   $id="$1_$i"; if(exists $rssite{$id}){$exon{$id}=$exonid;}
  }
 }
 else{print "error exon minus:\t$_\n";}
}

print "Working on file 1\n";

while(<IN01>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/){$rawcount{$1}="$2\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0";}else{print "error count: $_\n";}}
while(<IN02>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2; 
 if($rawcount{$id}=~/^(\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN03>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN04>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN05>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN06>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}

print "Working on file 7\n";
while(<IN07>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN08>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN09>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN10>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}

print "Working on file 11\n";
while(<IN11>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN12>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN13>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN14>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+\t\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}

print "Working on file 15\n";
while(<IN15>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+\t(\d+)$/)
 {
  $rawcount{$id}="$1\t$count\t$2";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}
while(<IN16>){chomp;if(/^chr([\w\.\-\+]+)\t(\d+)$/)
{
 $id=$1; $count=$2;
 if($rawcount{$id}=~/^(\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+)\t\d+$/)
 {
  $rawcount{$id}="$1\t$count";
 }
 else{print"error HASH Values: $rawcount{$id}\n";}
}
else{print "error count: $_\n";}
}


 
print OUA "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\t";
print OUA "Cell6w1\tCell6w2\tNuclear6w1\tNuclear6w2\tmRNA8w1\tmRNA8w2\t";
print OUA "Exc6w1\tExc6w2\tExc6w3\tExc6w4\tInh6w1\tInh6w2\tInh6w3\tInh6w4\t";
print OUA "Female18w1\tFemale18w2\n";

print OUB "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\t";
print OUB "Cell6w1\tCell6w2\tNuclear6w1\tNuclear6w2\tmRNA8w1\tmRNA8w2\t";
print OUB "Exc6w1\tExc6w2\tExc6w3\tExc6w4\tInh6w1\tInh6w2\tInh6w3\tInh6w4\t";
print OUB "Female18w1\tFemale18w2\n";

foreach $key (keys %rawcount)
{
 print OUA "$key\t"; print OUB "$key\t";
 
 if($key=~/^(\w\w?)\_([+|-])\_(\d+)\_(ENSMUSG\d+\_[\w\.\-]+)$/)
 {
  print OUA "$glength{$4}\t"; print OUB "$glength{$4}\t";
  if($2 eq "+"){$loci=$3+2;}elsif($2 eq "-"){$loci=$3-1;}else{print "error strand: $_\n";}
  $lociid="$1_$loci"; 

  if(exists $intron{$lociid})
  {
   print OUA "$intron{$lociid}\t$ilength{$intron{$lociid}}\t";
   print OUB "$intron{$lociid}\t$ilength{$intron{$lociid}}\t";
  }
  else{print OUA "-\t-\t"; print OUB "-\t-\t";}
  
  if(exists $exon{$lociid})
  {
   print OUA "$exon{$lociid}\t$elength{$exon{$lociid}}\t";
   print OUB "$exon{$lociid}\t$elength{$exon{$lociid}}\t";
  }
  else{print OUA "-\t-\t"; print OUB "-\t-\t";}
 }
 else{print "error Key : $_\n";}

 print OUA "$rawcount{$key}\n";

 if($rawcount{$key}=~/^(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)$/)
 {
  $rp30m=int((($1 * 1000000)/36257900)*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($2 * 1000000)/31442771)*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($3 * 1000000)/39235398 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($4 * 1000000)/215104451 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($5 * 1000000)/130823726 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($6 * 1000000)/134517615 )*1000)/1000; print OUB "$rp30m\t";
 
  $rp30m=int((($7 * 1000000)/30346666 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($8 * 1000000)/37468411 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($9 * 1000000)/31748809 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($10 * 1000000)/45012072 )*1000)/1000; print OUB "$rp30m\t";

  $rp30m=int((($11 * 1000000)/35227353 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($12 * 1000000)/41299311 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($13 * 1000000)/31039428 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($14 * 1000000)/33660802 )*1000)/1000; print OUB "$rp30m\t";

  $rp30m=int((($15 * 1000000)/39570126 )*1000)/1000; print OUB "$rp30m\t";
  $rp30m=int((($16 * 1000000)/33746151 )*1000)/1000; print OUB "$rp30m\n";
 }
}




