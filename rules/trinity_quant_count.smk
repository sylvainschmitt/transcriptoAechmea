rule trinity_quant_count:
    input:
        "results/quantification/RSEM.gene.TPM.not_cross_norm",
        "results/quantification/RSEM.isoform.TPM.not_cross_norm"
    output:
        "results/quantification/RSEM.gene.TPM.not_cross_norm.counts_by_min_TPM",
        "results/quantification/RSEM.isoform.TPM.not_cross_norm.counts_by_min_TPM"
    log:
        "results/logs/trinity_quant_count.log"
    benchmark:
        "results/benchmarks/trinity_quant_count.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl {input[0]} | tee {output[0]} ; "
        "$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl {input[1]} | tee {output[1]}"