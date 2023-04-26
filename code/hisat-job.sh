#!/bin/bash
## Hisat Test
#SBATCH --job-name=hisattest
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=01-08:00:00
## Memory per node
#SBATCH --mem=100G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=stanja@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/stanja/assign_04

# load modules needed
module load HISAT2/2.2.1-foss-2019b
module load SAMtools/1.9-foss-2018b

#unzip reference genome
#gunzip Montipora_capitata_HIv3.assembly.fasta.gz

# index the reference genome for Montipora capitata output index to working directory
hisat2-build -f /home/shared/8TB_HDD_02/sarahtanja/sarahtanja-coralRNA/data/Montipora_capitata_HIv3.assembly.fasta ./Mcapitata_ref_v3 # called the reference genome (scaffolds)
echo "Referece genome indexed. Starting alignment" $(date)

# This script exports alignments as bam files
# sorts the bam file because Stringtie takes a sorted file for input (--dta)
# removes the sam file because it is no longer needed
array=($(ls clean*)) # call the clean sequences - make an array to align
for i in ${array[@]}; do
        sample_name=`echo $i| awk -F [.] '{print $2}'`
	hisat2 -p 8 --dta -x Mcapitata_ref_v3 -U ${i} -S ${sample_name}.sam
        samtools sort -@ 8 -o ${sample_name}.bam ${sample_name}.sam
    		echo "${i} bam-ified!"
        rm ${sample_name}.sam
done