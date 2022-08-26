rule tmhmm:
    input:
        "results/annotation/transdecoder/aechmea.fa.transdecoder.pep"
    output:
        "results/annotation/tmhmm/tmhmm.out"
    log:
        "results/logs/tmhmm.log"
    benchmark:
        "results/benchmarks/tmhmm.benchmark.txt"
    singularity:
        "docker://crhisllane/tmhmm:latest"
    threads: 1
    shell:
        "tmhmm -f {input} > {output}"