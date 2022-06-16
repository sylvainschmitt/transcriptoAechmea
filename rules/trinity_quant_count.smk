rule trinity_quantification:
    input:
        "results/quality/quantification/genes_matrix.TPM.not_cross_norm",
        "results/quality/quantification/trans_matrix.TPM.not_cross_norm"
    output:
        "results/quality/quantification/genes_matrix.TPM.not_cross_norm.counts_by_min_TPM",
        "results/quality/quantification/trans_matrix.TPM.not_cross_norm.counts_by_min_TPM"
    log:
        "results/logs/trinity_quantification.log"
    benchmark:
        "results/benchmarks/trinity_quantification.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl {input[0]} | tee {output[0]} ; "
        "$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl {input[1]} | tee {output[1]}"