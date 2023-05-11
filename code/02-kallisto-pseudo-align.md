02-kallisto-pseudo-align
================

Check kallisto `version` with the following command:

``` bash
/home/shared/kallisto/kallisto
```

# Create Index File

This code is indexing the file `Montipora_capitata_HIv3.genes.cds.fna`
while also renaming it as `mcap_rna.index`.
**/home/shared/kallisto/kallisto** is the absolute path to the kallisto
program from within the raven server, while the lines after the index
command indicate where to where to write the file to (`mcap_rna.index`)
and where to get the data from
(the`Montipora_capitata_HIv3.genes.cds.fna` file)

``` bash
/home/shared/kallisto/kallisto \
index -i \
../data/mcap_rna.index \
../data/Montipora_capitata_HIv3.genes.cds.fna
```

# Kallisto Quant

The next chunk performs the following steps:

- creates a subdirectory `kallisto_01` in the `output` folder using
  `mkdir`

- Uses the `find` utility to search for all files in the `../data/`
  directory that match the pattern `*fastq.gz`.

- Uses the `basename` command to extract the base filename of each file
  (i.e., the filename without the directory path), and removes the
  suffix `_L001_R1_001.fastq.gz`.

- Runs the kallisto `quant` command on each input file, with the
  following options:

- `-i ../data/mcap_rna.index`: Use the kallisto index file located at
  `../data/mcap_rna.index`.

- `-o ../output/kallisto_01/{}`: Write the output files to a directory
  called `../output/kallisto_01/` with a subdirectory named after the
  base filename of the input file (the {} is a placeholder for the base
  filename).

- `-t 40`: Use 40 threads for the computation.

- `--single -l 100 -s 10`: Specify that the input file contains
  single-end reads (–single), with an average read length of 100
  (-l 100) and a standard deviation of 10 (-s 10).

- The input file to process is specified using the {} placeholder, which
  is replaced by the base filename from the previous step.

``` bash
# uncomment the line of code below 
# mkdir ../output/kallisto_01

find /home/shared/8TB_HDD_01/mcap/*.fastq \
| xargs basename -s .fastq | xargs -I{} /home/shared/kallisto/kallisto \
quant -i ../data/mcap_rna.index \
-o ../output/kallisto_01/{} \
-t 40 \
--single -l 100 -s 10 ../data/{}.fastq
```

# Trinity Abundance Estimates, Gene Expression Matrix

This next command runs the `abundance_estimates_to_matrix.pl` script
from the Trinity RNA-seq assembly software package to create a gene
expression matrix from kallisto output files.

The specific options and arguments used in the command are as follows:

- `perl /home/shared/trinityrnaseq-v2.12.0/util/abundance_estimates_to_matrix.pl`:
  Run the abundance_estimates_to_matrix.pl script from Trinity.

  ``` bash

   /home/shared/trinityrnaseq-v2.12.0/util/abundance_estimates_to_matrix.pl
  ```

- `--est_method kallisto`: Specify that the abundance estimates were
  generated using kallisto.

- `--gene_trans_map none`: Do not use a gene-to-transcript mapping file.

- `--out_prefix ../output/kallisto_01`: Use ../output/kallisto_01 as the
  output directory and prefix for the gene expression matrix file.

- `--name_sample_by_basedir`: Use the sample directory name (i.e., the
  final directory in the input file paths) as the sample name in the
  output matrix.

- And then there are the kallisto abundance files to use as input for
  creating the gene expression matrix.

``` bash

perl /home/shared/trinityrnaseq-v2.12.0/util/abundance_estimates_to_matrix.pl \
--est_method kallisto \
    --gene_trans_map none \
    --out_prefix ../output/kallisto_01 \
    --name_sample_by_basedir \
    ../output/kallisto_01/SRR22293447/abundance.tsv \
    ../output/kallisto_01/SRR22293448/abundance.tsv \
    ../output/kallisto_01/SRR22293449/abundance.tsv \
    ../output/kallisto_01/SRR22293450/abundance.tsv \
    ../output/kallisto_01/SRR22293451/abundance.tsv \
    ../output/kallisto_01/SRR22293452/abundance.tsv \
    ../output/kallisto_01/SRR22293453/abundance.tsv \
    ../output/kallisto_01/SRR22293454/abundance.tsv 
```