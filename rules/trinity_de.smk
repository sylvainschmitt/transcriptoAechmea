rule trinity_de:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix",
        "data/sample.tsv"
    output:
        "results/expression/voom/RSEM.isoform.TMM.EXPR.matrix.Cam_femo_vs_Neo_goel.voom.DE_results"
    log:
        "results/logs/trinity_de.log"
    benchmark:
        "results/benchmarks/trinity_de.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix {input[0]} --samples {input[1]} --method voom "
        