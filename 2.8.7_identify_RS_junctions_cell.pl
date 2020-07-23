#! /usr/local/perl -w
# Criteria
# 1. Located in intron, not exon
# 2. Intron_length >=50 kb
# 3. Merged_junction_reads_cell(rep1+rep2) >=10
# 4. cell_RPM/mRNA_RPM > 1
# 5. AGGT motif
#
#
# Total-AGGT: 41405
# Intron: 10303	Intron_only: 9383	>=50kb: 2862	RS_candidate: 24
# Raw_cell_count_intron >=10: 128	Raw_nuclear_count_intron >=10: 300

open(INA,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_0.xls")||die("Can't open INA:$!\n");
open(OUT,">Result/02_Junction_reads/RS_junction_cell_0324.xls")||die("Can't write OUT:$!\n");


while(<INA>)
{
 chomp;
 if(/^\w\w?\_[+|-]\_\d+\_[\w\.\-\(\)]+\t\d+\t([\w\:\-\.]+)\t([\w\.\-]+)\t([\w\:\.\-]+)\t[\w\.\-]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t[\d\.]+\t([ATCG]+)\t(\d+)\t(\d+)\t(\d+)\t(\d+)\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+$/)
 {
  $intron=$1; $intron_length=$2; $exon=$3;
  $rpm_cell=$4+$5; $rpm_mRNA=$6+$7; $motif=$8; $raw_cell=$9+$10; $raw_nuclear=$11+$12;
  $line=$_;

  if($motif eq "AGGT")
  {
   $a1++;
   if($intron =~ /intron/) ## junction in intron
   {
    $a2++;
    if($exon =~ /exon/) {} ## intron length >= 50kb
    else ## Junction not in exon, only in intron
    {
     $a3++;
     if($intron_length >= 50000) ## intron length >= 50kb
     {
      $a4++;
      if(($raw_cell>=10) and ($rpm_cell > $rpm_mRNA))
      {
       $a5++;
       print OUT "$line\n";
      }
     }
     if($raw_nuclear>=10){$b1++;}
     if($raw_cell>=10){$b2++;}
    }
   }
  }
 }
 else{print "error1\t$_\n"; print OUT "$_\n";}
}

print "Total-AGGT: $a1\nIntron: $a2\tIntron_only: $a3\t>=50kb: $a4\tRS_candidate: $a5\n";
print "Raw_cell_count_intron >=10: $b2\tRaw_nuclear_count_intron >=10: $b1\n";


