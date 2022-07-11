rule trinity_super:
    input:
        "results/transcriptome/aechmea.fa"
    output:
        "results/super/trinity_genes.fasta",
        "results/super/trinity_genes.gtf"
    log:
        "results/logs/trinity_super.log"
    benchmark:
        "results/benchmarks/trinity_super.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/Analysis/SuperTranscripts/Trinity_gene_splice_modeler.py --trinity_fasta {input}"