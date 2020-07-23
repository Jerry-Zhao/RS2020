#! /usr/local/perl -w
 
## Extract RS-sites in gene sense regions
#open(INA,"Junctions/RS_sites_mm10.xls")||die("Can't open INA:$!\n");
#open(INB,"/media/Project/Genome/Ensembl_93/exon_intron/Mus_musculus.GRCm38.93.gtf.gene")||die("Can't open INA:$!\n");
#open(OUA,">Junctions/RS_sites_mm10_geneSense.xls")||die("Can't write OUT:$!\n");
#open(OUB,">Junctions/RS_sites_mm10_geneSense_count.xls")||die("Can't write OUT:$!\n");
# 
#Total-RS-sites: 20403114	Gene-sesen-RS-sites: 4767575
#Total-nonMT-genes: 32611	Gene-have-RS-sites: 29228

open(INA,"Junctions/RS_sites_hg38.xls")||die("Can't open INA:$!\n");
open(INB,"/media/Project/Genome/Ensembl_93/exon_intron/Homo_sapiens.GRCh38.93.gtf.gene")||die("Can't open INA:$!\n");
open(OUA,">Junctions/RS_sites_hg38_geneSense.xls")||die("Can't write OUT:$!\n");
open(OUB,">Junctions/RS_sites_hg38_geneSense_count.xls")||die("Can't write OUT:$!\n");
# 
#Total-RS-sites: 23065395	Gene-sesen-RS-sites: 6466467
#Total-nonMT-genes: 32132	Gene-have-RS-sites: 28651


while(<INA>)
{
 chomp;
 if(/^chr(\w\w?)\t([+|-])\t(\d+)$/)
 {
  $id="$1\t$3"; 
  if($1 ne "MT") ## not chrMT
  {
   $a1++;
   if($2 eq "+"){$plus{$id}=1;}
   elsif($2 eq "-"){$minus{$id}=1;}
   else{print "error strand $_\n";}
  }
 }
 else{print "error1\t$_\n";}
}


while(<INB>)
{
 chomp;
 if(/^(\w\w?)\t\w+\tgene\t(\d+)\t(\d+)\t([+|-])\t(\w+\t[\w\.\-]+)$/)
 {
  $label=0;
  ## + strand
  if($4 eq "+")
  {
   for ($i=$2;$i<=$3;$i++)
   {
    $id2="$1\t$i";
    if(exists $plus{$id2}){$label++; $a2++; print OUA "chr$1\t+\t$i\t$5\n";}
   }
  }
  elsif($4 eq "-")
  {
   for ($i=$2;$i<=$3;$i++)
   {
    $id2="$1\t$i";
    if(exists $minus{$id2}){$label++; $a2++; print OUA "chr$1\t-\t$i\t$5\n";}
   }
  }
  else{print "error strand: $_\n";}
 
  if($1 ne "MT")
  {
   $a3++; ## total non-MT genes 
   if($label>0){$a4++; print OUB "$label\t$5\tchr$1\t$2\t$3\t$4\n";}
  }
 }
 else{print "error2\t$_\n";}
}

print "Total-RS-sites: $a1\tGene-sesen-RS-sites: $a2\n";
print "Total-nonMT-genes: $a3\tGene-have-RS-sites: $a4\n";


