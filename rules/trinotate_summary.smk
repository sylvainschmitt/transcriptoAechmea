rule trinotate_summary:
    input:
       "results/trinotate_annotation_report.txt"
    output:
        "results/annotation/trinotate_table_fields.txt"
    log:
        "results/logs/trinotate_summary.log"
    benchmark:
        "results/benchmarks/trinotate_summary.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        "count_table_fields.pl {input} > {output}"
        