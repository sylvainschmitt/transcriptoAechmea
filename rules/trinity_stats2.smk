rule trinity_stats2:
    input:
        "results/transcriptome/aechmea.fa",
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix"
    output:
        "results/quality/stats/aechmea_ExN50_stats.txt"
    log:
        "results/logs/trinity_stats2.log"
    benchmark:
        "results/benchmarks/trinity_stats2.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/misc/contig_ExN50_statistic.pl {input[1]} {input[0]} | tee {output} ; "