#! /usr/local/perl -w
#
#
open(INA,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM.xls")||die("Can't open INA:$!\n");
open(INB,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_raw.xls")||die("Can't open INB:$!\n");
open(INC,"Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM.xls")||die("Can't open INC:$!\n");

open(OUA,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_1.xls");
open(OUB,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_nuclear.xls");
open(OUC,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_excitatory.xls");
open(OUD,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_inhibitory.xls");
open(OUE,">Result/02_Junction_reads/Junction_reads_AGNN_count_merged_RPM_female.xls");

while(<INA>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(($4+$5)>0){$nuclear{$1}=1;$a1++;}
  if(($7+$8+$9+$10)>0){$exc{$1}=1;$a2++;}
  if(($11+$12+$13+$14)>0){$inh{$1}=1;$a3++;}
  if(($15+$16)>0){$female{$1}=1;$a4++;}
 }
 else{print "error1\t$_\n";}
}

while(<INB>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(exists $nuclear{$1}){$nuclear{$1}="$4\t$5";}
  if(exists $exc{$1}){$exc{$1}="$7\t$8\t$9\t$10";}
  if(exists $inh{$1}){$inh{$1}="$11\t$12\t$13\t$14";}
  if(exists $female{$1}){$female{$1}="$15\t$16";}
 }
 else{print "error2\t$_\n";}
}

print OUB "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\tMotif\tmRNA1\tmRNA2\tCell1\tCell2\tNuclear1\tNuclear2\tRaw1\tRaw2\n";
print OUC "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\tMotif\tmRNA1\tmRNA2\tCell1\tCell2\tExc1\tExc2\tExc3\tExc4\tRaw1\tRaw2\tRaw3\tRaw4\n";
print OUD "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\tMotif\tmRNA1\tmRNA2\tCell1\tCell2\tInh1\tInh2\tInh3\tInh4\tRaw1\tRaw2\tRaw3\tRaw4\n";
print OUE "\tGene_len\tIntron\tIntron_len\tExon\tExon_len\tMotif\tmRNA1\tmRNA2\tCell1\tCell2\tFemale1\tFemale2\tRaw1\tRaw2\n";

while(<INC>)
{
 chomp;
 if(/^(\w\w?\_[+|-]\_[\w\.\-]+)\t(\d+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+\t[\w\.\-\:]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+\t[\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([ATCGN]+)$/)
 {
  if(($4+$5+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16)>1){print OUA "$_\n";} ## total RPM >1  

  ## Nuclear total RNA-seq
  if(($4+$5)>0){print OUB "$1\t$2\t$17\t$6\t$3\t$4\t$5\t$nuclear{$1}\n";}
  ## Excitatory neurons
  if(($7+$8+$9+$10)>0){print OUC "$1\t$2\t$17\t$6\t$3\t$7\t$8\t$9\t$10\t$exc{$1}\n";}
  ## Inhibitory neurons
  if(($11+$12+$13+$14)>0){print OUD "$1\t$2\t$17\t$6\t$3\t$11\t$12\t$13\t$14\t$inh{$1}\n";}
  ## Female 
  if(($15+$16)>0){print OUE "$1\t$2\t$17\t$6\t$3\t$15\t$16\t$female{$1}\n";}
 }
 else{print "error1\t$_\n"; print OUA "$_\n";}
}

print "Nuclear>0: $a1\nExc>0: $a2\nInh>0: $a3\nFemale>0: $a4\n";


