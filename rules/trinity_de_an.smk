rule trinity_de_an:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix",
        "results/annotation/trinotate_go_annotations.txt",
        "results/transcriptome/aechmea.gene_lengths.txt"
    output:
        "results/expression/{type}/diffExpr.P1e-3_C2.matrix.log2.centered.genes_vs_samples_heatmap.pdf"
    log:
        "results/logs/trinity_de_an_{type}.log"
    benchmark:
        "results/benchmarks/trinity_de_an_{type}.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    params:
        dir="results/expression/{type}",
    shell:
        "cp {input[0]} {params.dir} ; "
        "cp {input[1]} {params.dir} ; "
        "cp {input[2]} {params.dir} ; "
        "cd {params.dir} ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix RSEM.isoform.TMM.EXPR.matrix -P 1e-3 -C 2 "
        "--GO_annots trinotate_go_annotations.tx --gene_lengths aechmea.gene_lengths.txt"
        