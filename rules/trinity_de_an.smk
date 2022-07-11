rule trinity_de_an:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix"
    output:
        "results/expression/voom/analysis/diffExpr.P1e-3_C2.matrix.log2.centered.genes_vs_samples_heatmap.pdf"
    log:
        "results/logs/trinity_de_an.log"
    benchmark:
        "results/benchmarks/trinity_de_an.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix {input} -P 1e-3 -C 2"
        