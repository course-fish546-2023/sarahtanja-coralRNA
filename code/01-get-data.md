01-get-NCBI-sequences
================
Sarah Tanja
4/26/23

Environment pre-reqs:

- sequence data files deposited on NCBI
- code and commentary written in Quarto
- operating within RStudio on a Unix OS (Roberts Lab raven server)
- file structure:
  - code
  - data
  - output

## Install Packages

``` r
if ("tidyverse" %in% rownames(installed.packages()) == 'FALSE') install.packages('tidyverse')
if ("SRAdb" %in% rownames(installed.packages()) == 'FALSE') BiocManager::install("SRAdb")
```

## Load packages

``` r
library(SRAdb)
library(tidyverse)
```

## Get sample metadata

First we want to get an idea of the files we are downloading and the
samples that generated the data. We will start by looking at the
metadata for the samples.

``` bash
# navigate to data directory
cd ../data

# download metadata from the git repo into the data directory
curl -O https://raw.githubusercontent.com/AHuffmyer/EarlyLifeHistory_Energetics/master/Mcap2020/Data/TagSeq/Sample_Info.csv  
```

``` r
#pull data into R and rename it metadata 
metadata <- read_csv("../data/Sample_Info.csv")
```

### Check file integrity with `md5sum`

<div>

> **Info**
>
> [Learn How to Generate and Verify Files with MD5 Checksum in
> Linux](https://www.tecmint.com/generate-verify-check-files-md5-checksum-linux/)

</div>

``` bash
cd ../data
md5sum Sample_Info.csv > md5.transferred
```

``` bash
cd ../data
cmp Sample_Info.csv md5.transferred
```

> These files differ by 1 byte, and I haven’t yet figured out why…
> possibly a windows vs unix thing

``` r
#look at the metadata
head(metadata)
```

There are 39 samples (rows) with 8 metadata columns in this tibble
dataset (AH1 - AH39). These samples are *Montipora capitata* coral taken
at different life-stages (denoted by column names `time-stage` and
`code` ), and RNA extracted and sequenced using Tag-Seq.

<div>

[![](https://user-images.githubusercontent.com/32178010/211181816-cf21abb7-7038-4f86-9aca-3ca326a958ce.png)](https://github.com/AHuffmyer/EarlyLifeHistory_Energetics)

M. capitata development diagram by A. Huffmyer

</div>

# Get TagSeq FASTQ files from National Center for Biotechnology Information (NCBI) Sequence Read Archive (SRA)

<div>

> **Info**
>
> Checkout some background info on [The Sequence Read Archive
> (SRA)](https://linsalrob.github.io/ComputationalGenomicsManual/Databases/SRA.html#:~:text=A%20Study%20(SRP)%20has%20one,want%20to%20download%20from%20NCBI.)
> and the [SRA
> factsheet](https://www.ncbi.nlm.nih.gov/core/assets/sra/files/Factsheet_SRA.pdf)

</div>

NCBI sequences have been trimmed and cleaned and are ready for alignment
and analysis.

### Use SRA Run Selector to make a .txt file list of Run (SRR) numbers

> *“Results are called runs (SRR). Runs comprise the data gathered for a
> sample or sample bundle and refer to a defining experiment.”*

First, we need to obtain RNAseq files from NCBI from the project
[PRJNA900235](https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA900235).
In order to do this we need a list of SRR numbers that identify the
specific sequence files for RNA. Go to the [SRA Run
Selector](https://www.ncbi.nlm.nih.gov/Traces/study/?query_key=9&WebEnv=MCID_64358c3e49f6486f57b185c1&o=acc_s%3Aa)
for BioProject 900235 and select the files of interest.

To make things easier and faster, we’re going to compare 2 life-history
groups, with an n=4 for each group. In this case, let’s compare 4
Embryos (an early stage) to 4 Attached Recruits (a later stage).

<figure>
<img src="images/sra-run-selector.png" data-fig-align="center"
alt="SRA run selector, downloading 8 fastq files (4 Embryo, 4 Attached Recruits)" />
<figcaption aria-hidden="true">SRA run selector, downloading 8 fastq
files (4 Embryo, 4 Attached Recruits)</figcaption>
</figure>

Select the files of interest, click ‘Accession List’ and the list of
file run ID’s will be downloaded in a text file named `SRR_Acc_list.txt`
, upload this list into the `data` folder.

## Navigate to or create the directory where you will download the fastq files

``` bash
# move to large data hard-drive 
cd /home/shared/8TB_HDD_01
# make a new directory named 'mcap', short for Montipora capitata
mkdir mcap
```

# Download the fastq files

Roberts Lab Resources Github
[issue#1569](https://github.com/RobertsLab/resources/issues/1569) thread

Using `sratoolkit.3.0.2-ubuntu64` which is already downloaded in
`/home/shared` folder

<div>

> **Caution**
>
> The following code will take some time, run it and go take a wee break

</div>

``` bash
/home/shared/sratoolkit.3.0.2-ubuntu64/bin/./fasterq-dump \
--outdir /home/shared/8TB_HDD_01/mcap \
--progress \
SRR22293447 \
SRR22293448 \
SRR22293449 \
SRR22293450 \
SRR22293451 \
SRR22293452 \
SRR22293453 \
SRR22293454
```

Absolute path to fastq files in raven:

`/home/shared/8TB_HDD_01/mcap/`

Relative path to fastq files in raven:

`cd ../../../../../8TB_HDD_01/mcap/`

Check that the fastq files are downloaded:

``` bash
cd /home/shared/8TB_HDD_01/mcap/
ls
```

<div>

> **Tip**
>
> The fastq files have been downloaded from NCBI!

</div>