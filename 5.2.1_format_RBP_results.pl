#! /usr/local/perl -w
# http://rbpmap.technion.ac.il/
# Human/Mouse
# high_stringency
# Apply conservation filter

open(INA,"Result/05_motif/RBPmap_40up20down_high_stringency_0524.txt")||die("Can't open INA:$!\n");
open(INB,"Result/05_motif/RBPmap_40up20down_high_stringency_0524.txt")||die("Can't open INB:$!\n");
open(OUA,">Result/05_motif/RBPmap_40up20down_0.01.xls")||die("Can't write OUT:$!\n");
open(OUB,">Result/05_motif/RBPmap_40up20down_0.001.xls")||die("Can't write OUT:$!\n");
open(OUC,">Result/05_motif/RBPmap_40up20down_0.0001.xls")||die("Can't write OUT:$!\n");

while(<INA>)
{
 chomp;
 if(/^(chr\w\w?\_[+|-]\_\d+\_\w+)\s*$/){$id=$1;} 
 elsif(/^Protein:\s+([\w\-]+)\(Hs\/Mm\)/){$protein=$1;}
 elsif(/^\w+\s+chr\w\w?\:\d+\s+[a-z]+\s+[a-z]+\s+[\d\.]+\s+([\w\-\.]+)\s*$/)
 {
  if($1 < 0.01){$total1{$protein}=1;}
  if($1 < 0.001){$total2{$protein}=1;}
  if($1 < 0.0001){$total3{$protein}=1;}
 }
 elsif(/^Sequence\s+Position/){}
 elsif(/^[\s\=]*$/){}
 elsif(/^\*+$/){}
 else{print "error1 $_\n";}
}

print OUA "\tchr2_+_179627792_Cdh4\tchr9_-_29674403_Ntm\tchr9_-_49642257_Ncam1\tchr9_-_49719364_Ncam1\tchr9_+_28029505_Opcml\tchr9_+_47633924_Cadm1\tchr10_+_69595048_Ank3\tchr11_-_33718264_Kcnip1\tchr13_+_109333510_Pde4d\tchr13_+_109550007_Pde4d\tchr13_+_109614417_Pde4d\tchr14_+_119537648_Hs6st3\tchr16_-_67142933_Cadm2\tchr16_-_67364247_Cadm2\tchr16_-_74151682_Robo2\tchr16_+_40262266_Lsamp\tchr16_+_40655810_Lsamp\tchr16_+_40979498_Lsamp\tchr16_+_41206970_Lsamp\tchrX_-_51473338_Hs6st2\n";
print OUB "\tchr2_+_179627792_Cdh4\tchr9_-_29674403_Ntm\tchr9_-_49642257_Ncam1\tchr9_-_49719364_Ncam1\tchr9_+_28029505_Opcml\tchr9_+_47633924_Cadm1\tchr10_+_69595048_Ank3\tchr11_-_33718264_Kcnip1\tchr13_+_109333510_Pde4d\tchr13_+_109550007_Pde4d\tchr13_+_109614417_Pde4d\tchr14_+_119537648_Hs6st3\tchr16_-_67142933_Cadm2\tchr16_-_67364247_Cadm2\tchr16_-_74151682_Robo2\tchr16_+_40262266_Lsamp\tchr16_+_40655810_Lsamp\tchr16_+_40979498_Lsamp\tchr16_+_41206970_Lsamp\tchrX_-_51473338_Hs6st2\n";
print OUC "\tchr2_+_179627792_Cdh4\tchr9_-_29674403_Ntm\tchr9_-_49642257_Ncam1\tchr9_-_49719364_Ncam1\tchr9_+_28029505_Opcml\tchr9_+_47633924_Cadm1\tchr10_+_69595048_Ank3\tchr11_-_33718264_Kcnip1\tchr13_+_109333510_Pde4d\tchr13_+_109550007_Pde4d\tchr13_+_109614417_Pde4d\tchr14_+_119537648_Hs6st3\tchr16_-_67142933_Cadm2\tchr16_-_67364247_Cadm2\tchr16_-_74151682_Robo2\tchr16_+_40262266_Lsamp\tchr16_+_40655810_Lsamp\tchr16_+_40979498_Lsamp\tchr16_+_41206970_Lsamp\tchrX_-_51473338_Hs6st2\n";


foreach (keys %total1)
{
 $pid=$_; print OUA "$pid";

 open(INB,"Result/05_motif/RBPmap_40up20down_high_stringency_0524.txt")||die("Can't open INB:$!\n");
 my $label=0; 
 while(<INB>)
 {
  chomp;
  if(/^(chr\w\w?\_[+|-]\_\d+\_\w+)\s*$/){$id=$1;}
  elsif(/^Protein:\s+([\w\-]+)\(Hs\/Mm\)/){$protein=$1;}
  elsif(/^\w+\s+chr\w\w?\:\d+\s+[a-z]+\s+[a-z]+\s+[\d\.]+\s+([\w\-\.]+)\s*$/)
  {
   if(($1 < 0.01) and ($protein eq $pid)){$label=1;}
  }
  elsif(/^Sequence\s+Position/){}
  elsif(/^[\s\=]*$/){}
  elsif(/^\*{96}$/){if($label==0){print OUA "\t0";} elsif($label==1){print OUA "\t1";}}
  else{print "error1 $_\n";}
 }
 
 print OUA "\n";
 close INB;
}

foreach (keys %total2)
{
 $pid=$_; print OUB "$pid";

 open(INB,"Result/05_motif/RBPmap_40up20down_high_stringency_0524.txt")||die("Can't open INB:$!\n");
 my $label=0;
 while(<INB>)
 {
  chomp;
  if(/^(chr\w\w?\_[+|-]\_\d+\_\w+)\s*$/){$id=$1;}
  elsif(/^Protein:\s+([\w\-]+)\(Hs\/Mm\)/){$protein=$1;}
  elsif(/^\w+\s+chr\w\w?\:\d+\s+[a-z]+\s+[a-z]+\s+[\d\.]+\s+([\w\-\.]+)\s*$/)
  {
   if(($1 < 0.001) and ($protein eq $pid)){$label=1;}
  }
  elsif(/^Sequence\s+Position/){}
  elsif(/^[\s\=]*$/){}
  elsif(/^\*{96}$/){if($label==0){print OUB "\t0";} elsif($label==1){print OUB "\t1";}}
  else{print "error1 $_\n";}
 }

 print OUB "\n";
 close INB;
}


foreach (keys %total3)
{
 $pid=$_; print OUC "$pid";

 open(INB,"Result/05_motif/RBPmap_40up20down_high_stringency_0524.txt")||die("Can't open INB:$!\n");
 my $label=0;
 while(<INB>)
 {
  chomp;
  if(/^(chr\w\w?\_[+|-]\_\d+\_\w+)\s*$/){$id=$1;}
  elsif(/^Protein:\s+([\w\-]+)\(Hs\/Mm\)/){$protein=$1;}
  elsif(/^\w+\s+chr\w\w?\:\d+\s+[a-z]+\s+[a-z]+\s+[\d\.]+\s+([\w\-\.]+)\s*$/)
  {
   if(($1 < 0.0001) and ($protein eq $pid)){$label=1;}
  }
  elsif(/^Sequence\s+Position/){}
  elsif(/^[\s\=]*$/){}
  elsif(/^\*{96}$/){if($label==0){print OUC "\t0";} elsif($label==1){print OUC "\t1";}}
  else{print "error1 $_\n";}
 }

 print OUC "\n";
 close INB;
}


