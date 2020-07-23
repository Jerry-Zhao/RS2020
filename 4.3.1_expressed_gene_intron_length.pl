#! /usr/local/perl -w
# Expressed gene: Exonic FPKM >=1

# Total-gene: 32746	 Expressed (mean Exonic FPKM>=1): 14857	  Output-expressed: 14794

open(INA,"Result/FPKM_merged_exonic_gene_Jerry.xls")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf.gene")||die("Can't open INB:$!\n");
open(INC,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_plus_final.intron")||die("Can't open INC:$!\n");
open(IND,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf_minus_final.intron")||die("Can't open IND:$!\n");

open(OUA,">Result/04_RS_intron/Expressed_gene_length.xls")||die("Can't write OUA:$!\n");
open(OUB,">Result/04_RS_intron/Expressed_gene_intron_length.xls")||die("Can't write OUB:$!\n");

open(OUC,">Result/Ensembl_93_Protein_Coding_gene_Length.xls")||die("Can't write OUC:$!\n");



while(<INA>)
{
 chomp;
 if(/^(ENSMUSG\d+\_[\w\.\-\(\)]+)\t[\d\.]+\t[\d\.]+\t([\d\.]+)\t([\d\.]+)\t/)
 {
  $a1++;
  $mean_fpkm=($2+$3)/2;
  if($mean_fpkm >= 1) {$expressed{$1}="$2\t$3"; $a2++;}
 }
 else{print "error1\t$_\n";}
}

print OUA "\tFPKM1\tFPKM2\tLength\n";
print OUC "\tLength\tLength2\n";
while(<INB>)
{
 chomp;
 if(/^\w\w?\t([\w\_]+)\t\w+\t(\d+)\t(\d+)\t[+|-]\t(ENSMUSG\d+)\t([\w\.\-\(\)]+)\s*$/)
 {
  $gene_length=$3-$2+1;  $id="$4_$5";
  if(exists $expressed{$id}){$a3++; print OUA "$id\t$expressed{$id}\t$gene_length\n";}

  if($1 eq "protein_coding") {print OUC "$id\t$gene_length\t$gene_length\n";}
 }
 else{print "error2\t$_\n";}
}


print OUB "\tFPKM1\tFPKM2\tIntron_length\n";
while(<INC>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_(intron\d+)\t\+$/)
 {
  $id2="$1:$2-$3:$4_$5"; $intron_length=$3-$2+1;
  if(exists $expressed{$4}) {print OUB "$id2\t$expressed{$4}\t$intron_length\n";}
 }
 else{print "error3\t$_\n";}
}

while(<IND>)
{
 chomp;
 if(/^(chr\w\w?)\:(\d+)\-(\d+)\:(ENSMUSG\d+\_[\w\.\-\(\)]+)\_(intron\d+)\t\-$/)
 {
  $id3="$1:$2-$3:$4_$5"; $intron_length=$3-$2+1;
  if(exists $expressed{$4}) {print OUB "$id3\t$expressed{$4}\t$intron_length\n";}
 }
 else{print "error4\t$_\n";}
}

print "Total-gene: $a1\t Expressed (mean Exonic FPKM>=1): $a2\t  Output-expressed: $a3\n";

close INA; close INB; close INC; close IND;
close OUA; close OUB;

