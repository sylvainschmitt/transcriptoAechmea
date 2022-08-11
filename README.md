transcriptoAechmea
================
Sylvain Schmitt
May 31, 2022

  - [Installation](#installation)
  - [Usage](#usage)
      - [Locally](#locally)
      - [Tabebuia](#tabebuia)
  - [Workflow](#workflow)
      - [Transcriptome](#transcriptome)
      - [Quality check](#quality-check)
      - [Quantification](#quantification)
      - [Annotation](#annotation)
      - [Differential expression](#differential-expression)
      - [Super transcripts](#super-transcripts)

[`singularity` &
`snakemake`](https://github.com/sylvainschmitt/snakemake_singularity)
workflow for trancriptomic analyses of *Aechmea* species.

![Workflow.](dag/dag.svg)

# Installation

  - [x] Python ≥3.5
  - [x] Snakemake ≥5.24.1
  - [x] Golang ≥1.15.2
  - [x] Singularity ≥3.7.3
  - [x] This workflow

<!-- end list -->

``` bash
# Python
sudo apt-get install python3.5
# Snakemake
sudo apt install snakemake`
# Golang
export VERSION=1.15.8 OS=linux ARCH=amd64  # change this as you need
wget -O /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz && \
sudo tar -C /usr/local -xzf /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
source ~/.bashrc
# Singularity
mkdir -p ${GOPATH}/src/github.com/sylabs && \
  cd ${GOPATH}/src/github.com/sylabs && \
  git clone https://github.com/sylabs/singularity.git && \
  cd singularity
git checkout v3.7.3
cd ${GOPATH}/src/github.com/sylabs/singularity && \
  ./mconfig && \
  cd ./builddir && \
  make && \
  sudo make install
# detect Mutations
git clone git@github.com:sylvainschmitt/transcriptoAechmea.git
cd transcriptoAechmea
```

# Usage

## Locally

``` bash
snakemake -np -j 3 --resources mem_mb=10000 # dry run
snakemake --dag | dot -Tsvg > dag/dag.svg # dag
```

## Tabebuia

``` bash
snakemake -np # dry run
snakemake -j 30 --use-singularity --singularity-args "\-B /home/ECOFOG/sylvain.schmitt/Documents/data/Aechmea" # run with binded data
snakemake --dag | dot -Tsvg > dag/dag.svg # dag
```

# Workflow

## Transcriptome

### [trinity](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity.smk)

  - Tools:
    [trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

## Quality check

### [busco](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/busco.smk)

  - Tools: [busco](https://busco.ezlab.org/)
  - Singularity: docker://ezlabgva/busco:v5.2.2\_cv2

### [blast uniprot](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/blast_uniprot.smk)

  - Tools:
    [blastx](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Counting-Full-Length-Trinity-Transcripts)
  - Singularity: docker://ncbi/blast
  - Base:
    <ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz>

### [trinity blastplus](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_blastplus.smk)

  - Tools:
    [analyze\_blastPlus\_topHit\_coverage](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Counting-Full-Length-Trinity-Transcripts)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [bowtie2 reads](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/bowtie2_reads.smk)

  - Tools:
    [bowtie2](https://github.com/trinityrnaseq/trinityrnaseq/wiki/RNA-Seq-Read-Representation-by-Trinity-Assembly)
  - Singularity: docker://biocontainers/bowtie2

### [trinity stats](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_stats.smk)

  - Tools:
    [TrinityStats](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Contig-Nx-and-ExN50-stats)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [samtools view](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/samtools_view.smk)

  - Tools:
    [samtools](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Examine-Strand-Specificity)
  - Singularity: docker://biocontainers/samtools

### [trinity strand](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_strand.smk)

  - Tools:
    [TrinityStats](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Examine-Strand-Specificity)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [trinity PtR](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_ptr.smk)

  - Tools:
    [PtR](https://github.com/trinityrnaseq/trinityrnaseq/wiki/QC-Samples-and-Biological-Replicates)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

## Quantification

### [trinity quantification](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_quantification.smk)

  - Tools:
    [align\_and\_estimate\_abundance](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Transcript-Quantification)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [trinity quant matrix](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_quant_matrix.smk)

  - Tools:
    [abundance\_estimates\_to\_matrix](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Transcript-Quantification)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [trinity quant count](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_quant_count.smk)

  - Tools:
    [count\_matrix\_features\_given\_MIN\_TPM\_threshold](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Transcript-Quantification)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

## Annotation

### [trinotate db](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinotate_db.smk)

  - Tools:
    [Build\_Trinotate\_Boilerplate\_SQLite\_db.pl](https://github.com/Trinotate/Trinotate.github.io/wiki/Software-installation-and-data-required#2-sequence-databases-required)
  - Singularity: docker://ss93/trinotate-3.2.1

### [transdecoder](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/transdecoder.smk)

  - Tools:
    [TransDecoder](https://github.com/TransDecoder/TransDecoder/wiki)
  - Singularity:
    oras://registry.forgemia.inra.fr/gafl/singularity/transdecoder/transdecoder:latest

### [tmhmm](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/tmhmm.smk)

  - Tools:
    [tmhmm](https://services.healthtech.dtu.dk/service.php?TMHMM-2.0)
  - Singularity: docker://crhisllane/tmhmm:latest

### [hmmscan](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/hmmscan.smk)

  - Tools: [hmmscan](http://eddylab.org/software/hmmer/Userguide.pdf)
  - Singularity: docker://dockerbiotools/hmmer:latest

### [blastp](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/blastp.smk)

  - Tools:
    [blastp](https://ftp.ncbi.nlm.nih.gov/pub/factsheets/HowTo_BLASTGuide.pdf)
  - Singularity: docker://ncbi/blast

### [blastx](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/blastx.smk)

  - Tools:
    [blastx](https://ftp.ncbi.nlm.nih.gov/pub/factsheets/HowTo_BLASTGuide.pdf)
  - Singularity: docker://ncbi/blast

### [rnammer](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/rnammer.smk)

  - Tools:
    [RnammerTranscriptome.pl](https://github.com/Trinotate/Trinotate.github.io/wiki/Software-installation-and-data-required#running-rnammer-to-identify-rrna-transcripts)
  - Singularity: docker://quay.io/biocontainer/trinotate

### [rename\_fasta\_headers](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/rename_fasta_headers.smk)

  - Script:
    [rename\_fasta\_headers.py](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/scripts/rename_fasta_headers.py)

### [signalp](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/signalp.smk)

  - Tools:
    [signalp](https://services.healthtech.dtu.dk/service.php?SignalP-5.0)
  - Singularity: <https://github.com/biocorecrg/interproscan_docker>

### [rename\_gff](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/rename_gff.smk)

  - Script:
    [rename\_gff.R](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/scripts/rename_gff.R)

### [trinotate load](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinotate_load.smk)

  - Tools: [Trinotate
    LOAD\_\*](https://github.com/Trinotate/Trinotate.github.io/wiki/Loading-generated-results-into-a-Trinotate-SQLite-Database-and-Looking-the-Output-Annotation-Report)
  - Singularity: docker://ss93/trinotate-3.2.1

### [trinotate report](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinotate_report.smk)

  - Tools: [Trinotate
    report](https://github.com/Trinotate/Trinotate.github.io/wiki/Loading-generated-results-into-a-Trinotate-SQLite-Database-and-Looking-the-Output-Annotation-Report#trinotate-output-an-annotation-report)
  - Singularity: docker://ss93/trinotate-3.2.1

## Differential expression

### [trinity DE](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_de.smk)

  - Tools:
    [run\_DE\_analysis.pl](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Differential-Expression#running-differential-expression-analysis)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [trinity DEA](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_de_an.smk)

  - Tools:
    [analyze\_diff\_expr.pl](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Differential-Expression#extracting-and-clustering-differentially-expressed-transcripts)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

## Super transcripts

### [trinity super](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_super.smk)

  - Tools:
    [Trinity\_gene\_splice\_modeler.py](https://github.com/trinityrnaseq/trinityrnaseq/wiki/SuperTranscripts)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [trinity super DU](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/trinity_super_de.smk)

  - Tools:
    [dexseq\_wrapper.pl](https://github.com/trinityrnaseq/trinityrnaseq/wiki/DiffTranscriptUsage)
  - Singularity:
    <https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg>

### [star](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/star.smk)

  - Tools:
    [STAR](https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf)
  - Singularity: docker://mgibio/star

### [picard](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/picard.smk)

  - Tools:
    [PICARD](https://gatk.broadinstitute.org/hc/en-us/articles/360037052812-MarkDuplicates-Picard-)
  - Singularity: docker://broadinstitute/gatk:4.2.6.1

### [gatk](https://github.com/sylvainschmitt/transcriptoAechmea/blob/main/rules/gatk.smk)

  - Tools:
    [GATK4](https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller)
  - Singularity: docker://broadinstitute/gatk:4.2.6.1
