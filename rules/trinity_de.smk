rule trinity_de:
    input:
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix",
        "data/sample_{type}.tsv"
    output:
        "results/expression/{type}/RSEM.isoform.TMM.EXPR.matrix.Cam_femo_vs_Neo_goel.voom.DE_results"
    log:
        "results/logs/trinity_de_{type}.log"
    benchmark:
        "results/benchmarks/trinity_de_{type}.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    params:
        dir="results/expression/{type}",
        sample="sample_{type}.tsv"
    shell:
        "cp {input[0]} {params.dir} ; "
        "cp {input[1]} {params.dir} ; "
        "cd {params.dir} ; "
        "pwd ; "
        "$TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix RSEM.isoform.TMM.EXPR.matrix --samples {params.sample} --method voom "
        