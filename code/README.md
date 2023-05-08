README
Sarah Tanja
last updated: `r format(Sys.time(), '%d %B, %Y')`
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

#### 02-align-hisat

In-progress alignment of sample sequences to reference genome using
HISAT

#### 04-create-kallisto-index

Alignment of sample sequences to reference index using kallisto, however
possibly not the appropriate tool, as kallisto is a ‘pseudo-aligner’ and
HISAT should be used for organisms that have an annotated genome. Count
matrix generated, but don’t trust it?

#### 05-DESeq2

DESeq2 differential gene expression analysis using dubious kallisto
count matrix

#### 06-GOSeq-enrichment

Functional enrichment of WGCNA (Weighted Gene Co-expression Network
Analysis) modules produced in `WGCNA_Mcap.Rmd` script for the *Montipora
capitata* 2020 developmental time series. This script uses the V3 genome
from Cyanophora Rutgers.

week05-presentation is published using Rpubs and can be found
[HERE](http://rpubs.com/sarah_tanja/1034364).
