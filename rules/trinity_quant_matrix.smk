rule trinity_quant_matrix:
    input:
        gene_trans_map="results/transcriptome/aechmea.fa.gene_trans_map",
        samples=""
    output:
        "results/quality/quantification/aechmea.TMM.EXPR.matrix"
    log:
        "results/logs/trinity_quant_matrix.log"
    benchmark:
        "results/benchmarks/trinity_quant_matrix.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/abundance_estimates_to_matrix.pl --est_method RSEM --gene_trans_map {input.gene_trans_map} {input.samples} ; "
