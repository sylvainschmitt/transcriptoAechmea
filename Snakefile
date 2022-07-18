import pandas as pd

configfile: "config/config.yml"

samples = pd.read_csv("data/sample.tsv", sep="\t", 
                      names=["condition", "sample", "R1", "R2"])

rule all:
   input:
        "results/transcriptome/aechmea.fa", # trsc 
        "results/quality/aechmea_busco", # qc 
        "results/quality/full_length/blastx.outfmt6.hist",
        "results/quality/reads_reps/align_stats.txt",
        "results/quality/stats/aechmea_stats.txt",
        "results/quality/stats/aechmea_ExN50_stats.txt",
        "results/quality/reads_reps/ss_analysis.dat",
        "results/quality/ptr/RSEM.isoform.TMM.EXPR.matrix.minRow10.CPM.log2.sample_cor_matrix.pdf",
        expand("results/quantification/{sample}/RSEM.{type}.results",
                sample=samples["sample"], type=["isoforms", "genes"]), # quantif 
        "results/quantification/RSEM.gene.TPM.not_cross_norm",
        "results/quantification/RSEM.isoform.TPM.not_cross_norm",
        "results/quantification/RSEM.gene.TPM.not_cross_norm.counts_by_min_TPM",
        "results/quantification/RSEM.isoform.TPM.not_cross_norm.counts_by_min_TPM",
        "results/expression/voom/RSEM.isoform.TMM.EXPR.matrix.Cam_femo_vs_Neo_goel.voom.DE_results", # de
        "results/expression/voom/analysis/diffExpr.P1e-3_C2.matrix.log2.centered.genes_vs_samples_heatmap.pdf",
        "results/super/trinity_genes.fasta", # super trsc 
        "results/super/trinity_genes.gtf",
        "results/super/expression/DTU.dexseq.results.dat"

# Rules #

## transcriptome ## 
include: "rules/trinity.smk"

## qc ## 
include: "rules/busco.smk" # gene completness 
include: "rules/blast_uniprot.smk" # full-length proteins
include: "rules/trinity_blastplus.smk"
include: "rules/bowtie2_reads.smk" # read representation
include: "rules/trinity_stats.smk" # n50
include: "rules/trinity_stats2.smk" # e90n50
include: "rules/samtools_view.smk" # strand specificity
include: "rules/trinity_strand.smk"
include: "rules/trinity_ptr.smk"

## quantification ## 
include: "rules/trinity_quantification.smk"
include: "rules/trinity_quant_matrix.smk"
include: "rules/trinity_quant_count.smk"

## annotation ## 

## differential expression ## 
include: "rules/trinity_de.smk"
include: "rules/trinity_de_an.smk"

## super transcripts ## 
include: "rules/trinity_super.smk"
include: "rules/trinity_super_de.smk"
