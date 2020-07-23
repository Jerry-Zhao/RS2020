
infile=(GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep1 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep2 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep3 GSE83474_Male_excitatory_6w_WT_nuclear_RNAseq_rep4 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep1 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep2 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep3 GSE83474_Male_inhibitory_6w_WT_nuclear_RNAseq_rep4 GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep1 GSE83474_Female_excitatory_18W_WT_WT_nuclear_RNAseq_rep2)
#infile=(GSE90205_GingerasLab_8w_Cortex_rep1 GSE90205_GingerasLab_8w_Cortex_rep2)

#infile=(GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep1 GSE83474_Male_cortex_6w_WT_wholeCell_RNAseq_rep2 GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep1 GSE83474_Male_cortex_6w_WT_nuclear_RNAseq_rep2)


for inputname in "${infile[@]}"
do
    # sam header
    cd "/media/Data/NYIT/RS/BAM"
    samtools view -H "${inputname}.bam" -o "${inputname}.header.sam"
    mv "${inputname}.header.sam" "/media/Project/RS/Junctions"

    # junction bam
    cd "/media/Project/RS/Junctions"
    cat "${inputname}.header.sam" "${inputname}.junction.sam" > "${inputname}.J.sam"
    samtools view -bS "${inputname}.J.sam" -o  "${inputname}_rawJ.bam" ## convert sam to bam
    samtools sort "${inputname}_rawJ.bam" -o "${inputname}_Junc.bam"      ## sort ba
    samtools index "${inputname}_Junc.bam"                               ## index bam
    rm "${inputname}_rawJ.bam"                                       ## remove unsorted bam
done


