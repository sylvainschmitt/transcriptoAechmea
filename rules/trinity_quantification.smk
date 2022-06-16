rule trinity_quantification:
    input:
        trsc="results/transcriptome/aechmea.fa"
    output:
        "results/quantification/aechmea_stats.txt"
    log:
        "results/logs/trinity_quantification.log"
    benchmark:
        "results/benchmarks/trinity_quantification.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    threads: 10
    shell:
        "$TRINITY_HOME/util/align_and_estimate_abundance.pl --transcripts {input.trsc} --seqType fq "
        "--samples_file {input.samples_file} --est_method RSEM --thread_count {threads} -- gene_trans_map {input.gene_trans_map}"
        