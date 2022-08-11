rule picard:
    input:
        "results/super/variants/x.bam"
    output:
        "results/super/variants/x.md.bam",
        "results/super/variants/x.bam.metrics"
    log:
        "results/logs/picard.log"
    benchmark:
        "results/benchmarks/picard.benchmark.txt"
    singularity:
        "docker://broadinstitute/gatk:4.2.6.1"
    threads: 30
    resources:
        mem_mb=150000
    shell:
        "gatk MarkDuplicates --java-options \"-Xmx150G -Xms1G\" I={input} O={output[0]} M={output[1]}"
        