### Analyzing the RNASeq data
printf "\n!!!!!!! \nHi Jerry, a new journey of paired-end RNA-seq analysis has began.\n!!!!!!!\n\n"

#echo -n "Please enter the input FASTQ file: donot need '_1.fastq.gz': " 
#read inputname

#infile=(Test)

#infile=(GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1 GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2 GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1)
#infile=(GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2)
 
#infile=(GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4 GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1 GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2)

infile=(GSE90205_GingerasLab_8w_Cortex_rep1 GSE90205_GingerasLab_8w_Cortex_rep2)

for inputname in "${infile[@]}"
do
    cd "/media/Project/RS/FASTQ"
    #### Step 1: mapping use STAR
    echo "Working on sample ${inputname}  \n\n"
    printf "\n\n\n  Step 1 of 3: STAR mapping \n\n"
#    gunzip "${inputname}_1.fastq.gz"
#    gunzip "${inputname}_2.fastq.gz"
  
    mkdir "tmp1" ## map the temp directory for mapping
    mv "${inputname}_1.fastq" "tmp1" ## move FASTQ to the folder
    mv "${inputname}_2.fastq" "tmp1" ## move FASTQ to the folder
    cd "tmp1"
 
    STAR --genomeDir "/media/Project/Genome/STAR/mouse" --readFilesIn "${inputname}_1.fastq" "${inputname}_2.fastq" --runThreadN 40 --outFilterMultimapNmax 1 --outFilterMismatchNmax 3
    mv "Aligned.out.sam" "${inputname}.sam" ## rename the alignment SAM file
    mv "Log.final.out" "${inputname}.Log" ## rename the mapping statistics file
    head -n 50 "${inputname}.Log" ## the mapping statistics

    mv "${inputname}.sam" "../../BAM"
    mv "${inputname}_1.fastq" ".."
    mv "${inputname}_2.fastq" ".."
    mv "${inputname}.Log" "../../Statistics"

    cd ".."
    rm -rf "tmp1"
    gzip "${inputname}_1.fastq"
    gzip "${inputname}_2.fastq"
 


    #### Step 2: split the SAM file by chromosome 
    printf "\n\n\nStep 2 of 3: split sam by chromosome \n\n"
    cd "/media/Project/Split"
    #gawk "{ if (NR>25) print > \"${inputname}.sam.chr\"$3}" "/media/Project/RS/BAM/${inputname}.sam"
    #gawk -v tag=${inputname} 'NR>25 { print > tag".sam.chr"$3}' "/media/Project/RS/BAM/${inputname}.sam"
    awk -v tag=${inputname} 'NR>25 { print > tag".sam.chr"$3}' "/media/Project/RS/BAM/${inputname}.sam"


    #### Step 3: Generate bam and BigWig file from sam file
    printf "\n\n\nStep 3 of 3: generate bam and BigWig from SAM file \n\n"
    cd "/media/Project/RS/BAM"
    # sam to bam
    samtools view -bS "${inputname}.sam" -o  "${inputname}_raw.bam" ## convert sam to bam
    samtools sort "${inputname}_raw.bam" -o "${inputname}.bam"      ## sort ba
    samtools index "${inputname}.bam"                               ## index bam
    rm "${inputname}_raw.bam"                                       ## remove unsorted bam

    # bam to BigWig
    lines=`expr $(wc -l < "/media/Project/RS/BAM/${inputname}.sam"| tr -d " ") - 25` ## uniquely mapped reads
    bw_value=`expr $lines / 2000000` ### The normalized bw y-axes will be uniquely mapped read-pairs (Million)

    bamCoverage -b "${inputname}.bam" --filterRNAstrand forward --binSize 1 -p 40 -o "${inputname}_plus_${bw_value}.bw" 
    bamCoverage -b "${inputname}.bam" --filterRNAstrand reverse --binSize 1 -p 40 -o "${inputname}_minus_${bw_value}.bw"
    mv "${inputname}_plus_${bw_value}.bw" "../Tracks_NYIT" 
    mv "${inputname}_minus_${bw_value}.bw" "../Tracks_NYIT"

    rm "${inputname}.sam"
done

