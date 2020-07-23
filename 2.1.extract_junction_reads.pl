#! /usr/local/perl -w
## Extract juntion reads from paired-end sam files

print "Please enter the dataset name: \n";
chomp($name=<STDIN>);

open(OUT,">Junctions/$name.junction.sam")||die("Can't write OUT:$!\n");

open(IN01,"../Split/$name.sam.chr1")||die("Can't open INA:$!\n");
open(IN02,"../Split/$name.sam.chr2")||die("Can't open INA:$!\n");
open(IN03,"../Split/$name.sam.chr3")||die("Can't open INA:$!\n");
open(IN04,"../Split/$name.sam.chr4")||die("Can't open INA:$!\n");
open(IN05,"../Split/$name.sam.chr5")||die("Can't open INA:$!\n");
open(IN06,"../Split/$name.sam.chr6")||die("Can't open INA:$!\n");
open(IN07,"../Split/$name.sam.chr7")||die("Can't open INA:$!\n");
open(IN08,"../Split/$name.sam.chr8")||die("Can't open INA:$!\n");
open(IN09,"../Split/$name.sam.chr9")||die("Can't open INA:$!\n");
open(IN10,"../Split/$name.sam.chr10")||die("Can't open INA:$!\n");

open(IN11,"../Split/$name.sam.chr11")||die("Can't open INA:$!\n");
open(IN12,"../Split/$name.sam.chr12")||die("Can't open INA:$!\n");
open(IN13,"../Split/$name.sam.chr13")||die("Can't open INA:$!\n");
open(IN14,"../Split/$name.sam.chr14")||die("Can't open INA:$!\n");
open(IN15,"../Split/$name.sam.chr15")||die("Can't open INA:$!\n");
open(IN16,"../Split/$name.sam.chr16")||die("Can't open INA:$!\n");
open(IN17,"../Split/$name.sam.chr17")||die("Can't open INA:$!\n");
open(IN18,"../Split/$name.sam.chr18")||die("Can't open INA:$!\n");
open(IN19,"../Split/$name.sam.chr19")||die("Can't open INA:$!\n");
open(INX,"../Split/$name.sam.chrX")||die("Can't open INA:$!\n");
open(INY,"../Split/$name.sam.chrY")||die("Can't open INA:$!\n");

$label=0;
print "working on chromosome 1\n";
while(<IN01>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t1\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}
 

print "working on chromosome 2\n";
while(<IN02>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t2\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 3\n";
while(<IN03>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t3\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 4\n";
while(<IN04>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t4\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 5\n";
while(<IN05>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t5\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 6\n";
while(<IN06>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t6\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 7\n";
while(<IN07>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t7\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 8\n";
while(<IN08>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t8\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 9\n";
while(<IN09>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t9\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 10\n";
while(<IN10>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t10\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}












print "working on chromosome 11\n";
while(<IN11>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t11\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 12\n";
while(<IN12>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t12\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 13\n";
while(<IN13>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t13\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 14\n";
while(<IN14>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t14\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 15\n";
while(<IN15>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t15\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 16\n";
while(<IN16>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t16\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 17\n";
while(<IN17>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t17\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 18\n";
while(<IN18>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t18\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome 19\n";
while(<IN19>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\t19\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome X\n";
while(<INX>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\tX\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


print "working on chromosome Y\n";
while(<INY>)
{
 chomp;
 if(/^[\w\.\:]+\t(\d+)\tY\t\d+\t\d+\t(\w+)\t/)
 {
  if($1==99 or $1==163)
  {
   $label=0;$line1=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap 
  }
  elsif($1==147 or $1==83)
  {
   $line2=$_;
   if($2=~/N/){$label=1;} ## read has alignment gap
   if($label==1){print OUT "$line1\n$line2\n";}
  }
  else{print "Wrong sam FLAG value: $_\n";}
 }
 else{print "error $_\n";}
}


