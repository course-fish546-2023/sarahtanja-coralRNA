README
================


# Differential Gene Expression Analysis Code Folder


> **Important**
>
> **Pre-reqs:** This code folder contains relative paths that only work
> within the *raven* Roberts’ Lab Server, where the data for this
> assignment is housed


#### 00-git-ignore

This follows the instruction on how to automatically ignore large files
from [THIS COURSE
TUTORIAL](https://sr320.github.io/course-fish546-2023/assignments/02-DGE.html)
, manually execute a bash terminal command to find and add files \>1G
from repo to .gitignore
`find . -size +1G | sed 's|^./||g' | cat >> .gitignore` from
[THIS](https://github.com/sr320/course-fish546-2015/issues/43) Robert's
Lab Course Issue, and how to undo a commit that had a file in it which
was too large.

#### 01-get-data

Where TagSeq sample sequence fasta files from NCBI are downloaded and
the Rutgers *Montipora capitata* reference genome V3 is downloaded

ALIGN 

The main difference between using a pseudo aligner like Kallisto and a genome aligner like HISAT2 lies in their underlying algorithms and the information they utilize during the alignment process.

Alignment Approach:

Pseudo Aligner (Kallisto): Pseudo alignment methods like Kallisto do not perform a traditional alignment of sequencing reads to a reference genome. Instead, they employ an indexing strategy to quickly determine which transcripts or features (such as genes or isoforms) the reads are likely to have originated from. Kallisto uses the k-mer-based approach to quantify transcript abundances without explicitly mapping each read to a reference.
Genome Aligner (HISAT2): Genome aligners like HISAT2 align sequencing reads directly to a reference genome. They perform a more computationally intensive process of mapping each read to its exact position in the reference genome, taking into account potential mismatches, gaps, and splicing events.
Speed and Resource Efficiency:

Pseudo Aligner (Kallisto): Pseudo aligners are generally faster than traditional genome aligners because they do not perform a full read alignment. By using the k-mer indexing approach, Kallisto achieves fast and memory-efficient quantification of transcript abundances.
Genome Aligner (HISAT2): Genome aligners perform a more detailed alignment of reads to the reference genome, which can be computationally intensive and requires more memory and computational resources compared to pseudo aligners.
Reference Compatibility:

Pseudo Aligner (Kallisto): Pseudo aligners like Kallisto work well with transcriptome reference databases. They can quantify abundances of transcripts, isoforms, or genes based on the available transcriptome annotations.
Genome Aligner (HISAT2): Genome aligners are designed to work with genomic references that include both coding and non-coding regions. They can detect novel splice junctions, alternative splicing events, and other genomic features that are not captured in a transcriptome reference alone.
In summary, pseudo aligners like Kallisto are computationally efficient, suitable for transcript-level quantification, and work well with transcriptome references. On the other hand, genome aligners like HISAT2 provide more comprehensive alignment information and are capable of capturing novel genomic features but require more computational resources and time for alignment. The choice between the two depends on the specific analysis goals and available reference data.

#### 02a-pseudo-align-kallisto

In-progress alignment of sample sequences to reference genome using
HISAT

#### 03-differentially-expressed-genes-DESeq2

DESeq2 differential gene expression analysis using kallisto count matrix


#### 04-functional-enrichment-GOSeq

Functional enrichment of WGCNA (Weighted Gene Co-expression Network
Analysis) modules produced in `WGCNA_Mcap.Rmd` script for the *Montipora
capitata* 2020 developmental time series. This script uses the V3 genome
from Cyanophora Rutgers.

week05-presentation is published using Rpubs and can be found
[HERE](http://rpubs.com/sarah_tanja/1034364).
