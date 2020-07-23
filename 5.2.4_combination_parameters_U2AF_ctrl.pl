#! /usr/local/perl -w
#
# U2AF binding motif: combination of T, T, T, T, T/C, T/C/G
# Total of 58 motif sequences 
# TTTTTT GTTTTT TGTTTT TTGTTT TTTGTT TTTTGT TTTTTG CTTTTT TCTTTT TTCTTT 
# TTTCTT TTTTCT TTTTTC CCTTTT CTCTTT CTTCTT CTTTCT CTTTTC TCCTTT TCTCTT 
# TCTTCT TCTTTC TTCCTT TTCTCT TTCTTC TTTCCT TTTCTC TTTTCC CGTTTT CTGTTT 
# CTTGTT CTTTGT CTTTTG TCGTTT TCTGTT TCTTGT TCTTTG TTCGTT TTCTGT TTCTTG
# TTTCGT TTTCTG TTTTCG GCTTTT GTCTTT GTTCTT GTTTCT GTTTTC TGCTTT TGTCTT 
# TGTTCT TGTTTC TTGCTT TTGTCT TTGTTC TTTGCT TTTGTC TTTTGC
#
open(OUT,">Result/05_motif/Combine_Ptbp_motif_TCpercent_ctrl.xls")||die("Can't write OUT:$!\n");

print OUT "Motif\tTCpercent\tTpercent\tRS_Result\tRS_Total\tnonRS_Result\tnonRS_Total\tCtrl_Result\tCtrl_Total\n";

for($i=0.5; $i<=1; $i+=0.05)
{
 for($j=0; $j<=$i; $j+=0.05)
 {
  open(INA,"Result/05_motif/RS_sites_20up_percent.xls")||die("Can't open INA:$!\n");
  open(INB,"Result/05_motif/RSintrons_20up_percent_nonRS.xls")||die("Can't open INB:$!\n");
  open(INC,"Result/05_motif/CtrlIntrons_20up_percent.xls")||die("Can't open INC:$!\n");

  my $a1=$a2=$a3=$a4=$a5=$b1=$b2=$b3=$b4=$b5=$c1=$c2=$c3=$c4=$c5=0; 
  while(<INA>)
  {
   chomp;
   if(/^[\w\-\+\_]+\s+[ATCG]{74}([ATCG]{25})AGGT[ATCG]{101}\s+([ATCG]{8})\s+([\d\.]+)\s+([\d\.]+)\s+[\d\.]+\s+[\d\.]+\s+[\d\.]+$/)
   {
    $a1++; $motif=$2; $tccount=$3; $tcount=$4;
    if( ($1=~/TTTTTT/) or ($1=~/GTTTTT/) or ($1=~/TGTTTT/) or ($1=~/TTGTTT/) or ($1=~/TTTGTT/) or 
	($1=~/TTTTGT/) or ($1=~/TTTTTG/) or ($1=~/CTTTTT/) or ($1=~/TCTTTT/) or ($1=~/TTCTTT/) or
	($1=~/TTTCTT/) or ($1=~/TTTTCT/) or ($1=~/TTTTTC/) or ($1=~/CCTTTT/) or ($1=~/CTCTTT/) or
	($1=~/CTTCTT/) or ($1=~/CTTTCT/) or ($1=~/CTTTTC/) or ($1=~/TCCTTT/) or ($1=~/TCTCTT/) or
	($1=~/TCTTCT/) or ($1=~/TCTTTC/) or ($1=~/TTCCTT/) or ($1=~/TTCTCT/) or ($1=~/TTCTTC/) or
	($1=~/TTTCCT/) or ($1=~/TTTCTC/) or ($1=~/TTTTCC/) or ($1=~/CGTTTT/) or ($1=~/CTGTTT/) or
	($1=~/CTTGTT/) or ($1=~/CTTTGT/) or ($1=~/CTTTTG/) or ($1=~/TCGTTT/) or ($1=~/TCTGTT/) or
	($1=~/TCTTGT/) or ($1=~/TCTTTG/) or ($1=~/TTCGTT/) or ($1=~/TTCTGT/) or ($1=~/TTCTTG/) or
	($1=~/TTTCGT/) or ($1=~/TTTCTG/) or ($1=~/TTTTCG/) or ($1=~/GCTTTT/) or ($1=~/GTCTTT/) or
	($1=~/GTTCTT/) or ($1=~/GTTTCT/) or ($1=~/GTTTTC/) or ($1=~/TGCTTT/) or ($1=~/TGTCTT/) or
	($1=~/TGTTCT/) or ($1=~/TGTTTC/) or ($1=~/TTGCTT/) or ($1=~/TTGTCT/) or ($1=~/TTGTTC/) or
	($1=~/TTTGCT/) or ($1=~/TTTGTC/) or ($1=~/TTTTGC/) ) ## U2AF motifs
    {
     ## AGGTAAGT motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$a2++;}

     ## AGGTAAG T/G motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$a3++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$a3++;}

     ## AGGTAAG T/G/C motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$a4++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$a4++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$a4++;}

     ## AGGTAAG motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$a5++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$a5++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$a5++;}
     if(($motif eq "AGGTAAGA") and ($tccount >= $i) and ($tcount >= $j)){$a5++;}
    }
   }
   else{print "error1\t$_\n";}
  }


  while(<INB>)
  {
   chomp;
   if(/^[\w\-\+\_]+\s+[ATCG]{15}([ATCG]{25})AGGT[ATCG]{20}\s+([ATCG]{8})\s+([\d\.]+)\s+([\d\.]+)\s+[\d\.]+\s+[\d\.]+\s+[\d\.]+$/)
   {
    $b1++; $motif=$2; $tccount=$3; $tcount=$4;
    if( ($1=~/TTTTTT/) or ($1=~/GTTTTT/) or ($1=~/TGTTTT/) or ($1=~/TTGTTT/) or ($1=~/TTTGTT/) or
        ($1=~/TTTTGT/) or ($1=~/TTTTTG/) or ($1=~/CTTTTT/) or ($1=~/TCTTTT/) or ($1=~/TTCTTT/) or
        ($1=~/TTTCTT/) or ($1=~/TTTTCT/) or ($1=~/TTTTTC/) or ($1=~/CCTTTT/) or ($1=~/CTCTTT/) or
        ($1=~/CTTCTT/) or ($1=~/CTTTCT/) or ($1=~/CTTTTC/) or ($1=~/TCCTTT/) or ($1=~/TCTCTT/) or
        ($1=~/TCTTCT/) or ($1=~/TCTTTC/) or ($1=~/TTCCTT/) or ($1=~/TTCTCT/) or ($1=~/TTCTTC/) or
        ($1=~/TTTCCT/) or ($1=~/TTTCTC/) or ($1=~/TTTTCC/) or ($1=~/CGTTTT/) or ($1=~/CTGTTT/) or
        ($1=~/CTTGTT/) or ($1=~/CTTTGT/) or ($1=~/CTTTTG/) or ($1=~/TCGTTT/) or ($1=~/TCTGTT/) or
        ($1=~/TCTTGT/) or ($1=~/TCTTTG/) or ($1=~/TTCGTT/) or ($1=~/TTCTGT/) or ($1=~/TTCTTG/) or
        ($1=~/TTTCGT/) or ($1=~/TTTCTG/) or ($1=~/TTTTCG/) or ($1=~/GCTTTT/) or ($1=~/GTCTTT/) or
        ($1=~/GTTCTT/) or ($1=~/GTTTCT/) or ($1=~/GTTTTC/) or ($1=~/TGCTTT/) or ($1=~/TGTCTT/) or
        ($1=~/TGTTCT/) or ($1=~/TGTTTC/) or ($1=~/TTGCTT/) or ($1=~/TTGTCT/) or ($1=~/TTGTTC/) or
        ($1=~/TTTGCT/) or ($1=~/TTTGTC/) or ($1=~/TTTTGC/) ) ## U2AF motifs
    {
     ## AGGTAAGT motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$b2++;}
    
     ## AGGTAAG T/G motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$b3++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$b3++;}
    
     ## AGGTAAG T/G/C motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$b4++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$b4++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$b4++;}

     ## AGGTAAG motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$b5++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$b5++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$b5++;}
     if(($motif eq "AGGTAAGA") and ($tccount >= $i) and ($tcount >= $j)){$b5++;}
    }
   }
   else{print "error2\t$_\n";}
  }

  while(<INC>)
  {
   chomp;
   if(/^[\w\-\+\_]+\s+[ATCG]{15}([ATCG]{25})AGGT[ATCG]{20}\s+([ATCG]{8})\s+([\d\.]+)\s+([\d\.]+)\s+[\d\.]+\s+[\d\.]+\s+[\d\.]+$/)
   {
    $c1++; $motif=$2; $tccount=$3; $tcount=$4;
    if( ($1=~/TTTTTT/) or ($1=~/GTTTTT/) or ($1=~/TGTTTT/) or ($1=~/TTGTTT/) or ($1=~/TTTGTT/) or
        ($1=~/TTTTGT/) or ($1=~/TTTTTG/) or ($1=~/CTTTTT/) or ($1=~/TCTTTT/) or ($1=~/TTCTTT/) or
        ($1=~/TTTCTT/) or ($1=~/TTTTCT/) or ($1=~/TTTTTC/) or ($1=~/CCTTTT/) or ($1=~/CTCTTT/) or
        ($1=~/CTTCTT/) or ($1=~/CTTTCT/) or ($1=~/CTTTTC/) or ($1=~/TCCTTT/) or ($1=~/TCTCTT/) or
        ($1=~/TCTTCT/) or ($1=~/TCTTTC/) or ($1=~/TTCCTT/) or ($1=~/TTCTCT/) or ($1=~/TTCTTC/) or
        ($1=~/TTTCCT/) or ($1=~/TTTCTC/) or ($1=~/TTTTCC/) or ($1=~/CGTTTT/) or ($1=~/CTGTTT/) or
        ($1=~/CTTGTT/) or ($1=~/CTTTGT/) or ($1=~/CTTTTG/) or ($1=~/TCGTTT/) or ($1=~/TCTGTT/) or
        ($1=~/TCTTGT/) or ($1=~/TCTTTG/) or ($1=~/TTCGTT/) or ($1=~/TTCTGT/) or ($1=~/TTCTTG/) or
        ($1=~/TTTCGT/) or ($1=~/TTTCTG/) or ($1=~/TTTTCG/) or ($1=~/GCTTTT/) or ($1=~/GTCTTT/) or
        ($1=~/GTTCTT/) or ($1=~/GTTTCT/) or ($1=~/GTTTTC/) or ($1=~/TGCTTT/) or ($1=~/TGTCTT/) or
        ($1=~/TGTTCT/) or ($1=~/TGTTTC/) or ($1=~/TTGCTT/) or ($1=~/TTGTCT/) or ($1=~/TTGTTC/) or
        ($1=~/TTTGCT/) or ($1=~/TTTGTC/) or ($1=~/TTTTGC/) ) ## U2AF motifs
    {
     ## AGGTAAGT motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$c2++;}
    
     ## AGGTAAG T/G motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$c3++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$c3++;}
    
     ## AGGTAAG T/G/C motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$c4++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$c4++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$c4++;}

     ## AGGTAAG motif
     if(($motif eq "AGGTAAGT") and ($tccount >= $i) and ($tcount >= $j)){$c5++;}
     if(($motif eq "AGGTAAGC") and ($tccount >= $i) and ($tcount >= $j)){$c5++;}
     if(($motif eq "AGGTAAGG") and ($tccount >= $i) and ($tcount >= $j)){$c5++;}
     if(($motif eq "AGGTAAGA") and ($tccount >= $i) and ($tcount >= $j)){$c5++;}
    }
   }
   else{print "error3\t$_\n";}
  }

  print OUT "AGGTAAGT\t$i\t$j\t$a2\t$a1\t$b2\t$b1\t$c2\t$c1\n";
  print OUT "AGGTAAG[T|G]\t$i\t$j\t$a3\t$a1\t$b3\t$b1\t$c3\t$c1\n";
  print OUT "AGGTAAG[T|G|C]\t$i\t$j\t$a4\t$a1\t$b4\t$b1\t$c4\t$c1\n";
  print OUT "AGGTAAG\t$i\t$j\t$a5\t$a1\t$b5\t$b1\t$c5\t$c1\n";

  close INA; close INB; close INC;
 }
}

close OUT;
