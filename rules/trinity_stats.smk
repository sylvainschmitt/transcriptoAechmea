rule trinity_stats:
    input:
        "results/transcriptome/aechmea.fa",
        "results/quality/quantification/aechmea.TMM.EXPR.matrix"
    output:
        "results/quality/stats/aechmea_stats.txt",
        "results/quality/stats/aechmea_ExN50_stats.txt"
    log:
        "results/logs/trinity_stats.log"
    benchmark:
        "results/benchmarks/trinity_stats.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/TrinityStats.pl {input[0]} > {output[0]} ; "
        "$TRINITY_HOME/util/misc/contig_ExN50_statistic.pl {input[1]} {input[0]} | tee {output[1]} ; "