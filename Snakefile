configfile: "config/config.yml"

rule all:
   input:
       "results/transcriptome/aechmea.fa", # trsc 
       "results/quality/aechmea_busco", # qc 
       "results/quality/full_length/blastx.outfmt6.txt.w_pct_hit_length",
        "results/quality/stats/aechmea_stats.txt",
        "results/quality/stats/aechmea_ExN50_stats.txt",
       "results/quantification/aechmea_stats.txt" # quantif 

# Rules #

## transcriptome ## 
include: "rules/trinity.smk"

## qc ## 
include: "rules/busco.smk" # gene completness 
include: "rules/blast_uniprot.smk" # full-length proteins
include: "rules/trinity_blastplus.smk"
# include: "rules/bowtie2_reads.smk" # read representation
include: "rules/trinity_stats.smk" # e90n50
# strand specificity
# rnaquast
# replicates

## quantification ## 
include: "rules/trinity_quantification.smk"
include: "rules/trinity_quant_matrix.smk"
include: "rules/trinity_quant_count.smk"

## differential expression ## 

## super transcripts ## 

## annotation ## 
