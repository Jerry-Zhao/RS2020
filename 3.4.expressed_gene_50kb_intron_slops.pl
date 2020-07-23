#! /usr/local/perl -w
# exclude intron-slops from genes (mean-Exonic-FPKM <0.5)

open(INFPKM,"Result/FPKM_merged_exonic_gene_Jerry.xls")||die("Can't open INFPKM:$!\n");

open(INA,"Result/03_ML/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1_intronSlop.xls")||die("Can't open INA:$!\n");
open(INB,"Result/03_ML/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2_intronSlop.xls")||die("Can't open INA:$!\n");

open(INC,"Result/03_ML/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1_intronSlop.xls")||die("Can't open INA:$!\n");
open(IND,"Result/03_ML/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2_intronSlop.xls")||die("Can't open INA:$!\n");

open(INE,"Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1_intronSlop.xls")||die("Can't open INA:$!\n");
open(INF,"Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2_intronSlop.xls")||die("Can't open INA:$!\n");
open(ING,"Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3_intronSlop.xls")||die("Can't open INA:$!\n");
open(INH,"Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4_intronSlop.xls")||die("Can't open INA:$!\n");

open(INI,"Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1_intronSlop.xls")||die("Can't open INA:$!\n");
open(INJ,"Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2_intronSlop.xls")||die("Can't open INA:$!\n");
open(INK,"Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3_intronSlop.xls")||die("Can't open INA:$!\n");
open(INL,"Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4_intronSlop.xls")||die("Can't open INA:$!\n");

open(INM,"Result/03_ML/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1_intronSlop.xls")||die("Can't open INA:$!\n");
open(INN,"Result/03_ML/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2_intronSlop.xls")||die("Can't open INA:$!\n");

open(OUA,">Result/03_ML/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUB,">Result/03_ML/GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");

open(OUC,">Result/03_ML/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUD,">Result/03_ML/GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");

open(OUE,">Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUF,">Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUG,">Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUH,">Result/03_ML/GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");

open(OUI,">Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUJ,">Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUK,">Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUL,">Result/03_ML/GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");

open(OUM,">Result/03_ML/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");
open(OUN,">Result/03_ML/GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2_intronSlop_FPKM50k.xls")||die("Can't write OUA:$!\n");


while(<INFPKM>)
{
 chomp;
 if(/^(ENSMUSG[\w\.\-]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t[\d\.]+\t[\d\.]+\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)\t([\d\.]+)$/)
 {
  if(($2+$3)/2 >=0.5){$cell{$1}=1;}
  if(($4+$5)/2 >=0.5){$nuclear{$1}=1;}
  if(($6+$7+$8+$9)/4 >=0.5){$exc{$1}=1;}
  if(($10+$11+$12+$13)/4 >=0.5){$inh{$1}=1;}
  if(($14+$15)/2 >=0.5){$female{$1}=1;}
 }
 else{print "error FPKM: $_\n";}
}

while(<INA>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $cell{$3}) and (($2-$1+1)>=50000)){print OUA "$_\n";}}else{print "error-slop\t$_\n"; print OUA "$_\n";}}
while(<INB>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $cell{$3}) and (($2-$1+1)>=50000)){print OUB "$_\n";}}else{print "error-slop\t$_\n"; print OUB "$_\n";}}

while(<INC>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $nuclear{$3}) and (($2-$1+1)>=50000)){print OUC "$_\n";}}else{print "error-slop\t$_\n"; print OUC "$_\n";}}
while(<IND>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $nuclear{$3}) and (($2-$1+1)>=50000)){print OUD "$_\n";}}else{print "error-slop\t$_\n"; print OUD "$_\n";}}

while(<INE>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $exc{$3}) and (($2-$1+1)>=50000)){print OUE "$_\n";}}else{print "error-slop\t$_\n"; print OUE "$_\n";}}
while(<INF>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $exc{$3}) and (($2-$1+1)>=50000)){print OUF "$_\n";}}else{print "error-slop\t$_\n"; print OUF "$_\n";}}
while(<ING>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $exc{$3}) and (($2-$1+1)>=50000)){print OUG "$_\n";}}else{print "error-slop\t$_\n"; print OUG "$_\n";}}
while(<INH>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $exc{$3}) and (($2-$1+1)>=50000)){print OUH "$_\n";}}else{print "error-slop\t$_\n"; print OUH "$_\n";}}

while(<INI>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $inh{$3}) and (($2-$1+1)>=50000)){print OUI "$_\n";}}else{print "error-slop\t$_\n"; print OUI "$_\n";}}
while(<INJ>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $inh{$3}) and (($2-$1+1)>=50000)){print OUJ "$_\n";}}else{print "error-slop\t$_\n"; print OUJ "$_\n";}}
while(<INK>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $inh{$3}) and (($2-$1+1)>=50000)){print OUK "$_\n";}}else{print "error-slop\t$_\n"; print OUK "$_\n";}}
while(<INL>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $inh{$3}) and (($2-$1+1)>=50000)){print OUL "$_\n";}}else{print "error-slop\t$_\n"; print OUL "$_\n";}}

while(<INM>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $female{$3}) and (($2-$1+1)>=50000)){print OUM "$_\n";}}else{print "error-slop\t$_\n"; print OUM "$_\n";}}
while(<INN>){chomp;if(/^chr\w\w?\:(\d+)\-(\d+)\:(ENSMUSG[\w\.\-]+)\_intron\d+\t/){if((exists $female{$3}) and (($2-$1+1)>=50000)){print OUN "$_\n";}}else{print "error-slop\t$_\n"; print OUN "$_\n";}}


