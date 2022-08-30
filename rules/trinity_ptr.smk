rule trinity_ptr:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix",
        "data/sample_{type}.tsv"
    output:
        "results/expression/{type}/ptr/RSEM.isoform.TMM.EXPR.matrix.minRow10.CPM.log2.sample_cor_matrix.pdf"
    log:
        "results/logs/trinity_ptr_{type}.log"
    benchmark:
        "results/benchmarks/trinity_ptr_{type}.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    params:
        dir="results/expression/{type}/ptr/",
        sample="sample_{type}.tsv"
    shell:
        "cp {input[0]} {params.dir} ; "
        "cp {input[1]} {params.dir} ; "
        "cd {params.dir} ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.isoform.TMM.EXPR.matrix "
        "--samples {params.sample} --log2 --CPM --min_rowSums 10 --compare_replicates ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.isoform.TMM.EXPR.matrix "
        "--samples {params.sample} --log2 --CPM --min_rowSums 10 --sample_cor_matrix ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/PtR --matrix RSEM.isoform.TMM.EXPR.matrix "
        "--samples {params.sample} --log2 --CPM --min_rowSums 10 --center_rows --prin_comp 3  ; "
        