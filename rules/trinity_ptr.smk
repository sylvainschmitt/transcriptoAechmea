rule trinity_ptr:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix",
        "data/sample.tsv"
    output:
        "results/quality/ptr/RSEM.isoform.TMM.EXPR.matrix.minRow10.CPM.log2.sample_cor_matrix.pdf"
    log:
        "results/logs/trinity_ptr.log"
    benchmark:
        "results/benchmarks/trinity_ptr.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix {input[0]} "
        "--samples {input[1]} --log2 --CPM --min_rowSums 10 --compare_replicates ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix {input[0]} "
        "--samples {input[1]} --log2 --CPM --min_rowSums 10 --sample_cor_matrix ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix {input[0]} "
        "--samples {input[1]} --log2 --CPM --min_rowSums 10 --center_rows --prin_comp 3  ; "
        