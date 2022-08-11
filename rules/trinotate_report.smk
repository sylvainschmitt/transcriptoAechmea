rule trinotate_report:
    input:
        "results/annotation/aechmea.sqlite"
    output:
        "results/trinotate_annotation_report.txt"
    log:
        "results/logs/trinotate_report.log"
    benchmark:
        "results/benchmarks/trinotate_report.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        'Trinotate {input} report > {output} 2> {log}'
        