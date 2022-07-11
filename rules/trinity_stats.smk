rule trinity_stats:
    input:
        "results/transcriptome/aechmea.fa",
        "results/quantification/RSEM.gene.TMM.EXPR.matrix"
    output:
        "results/quality/stats/aechmea_stats.txt"
    log:
        "results/logs/trinity_stats.log"
    benchmark:
        "results/benchmarks/trinity_stats.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/TrinityStats.pl {input[0]} > {output[0]}"