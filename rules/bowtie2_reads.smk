rule bowtie2_reads:
    input:
        "results/transcriptome/aechmea.fa",
        reads_1.fq,
        reads_2.fq
    output:
        "results/quality/reads_reps/align_stats.txt",
        "results/quality/reads_reps/bowtie2.sam"
    log:
        "results/logs/bowtie2_reads.log"
    benchmark:
        "results/benchmarks/bowtie2_reads.benchmark.txt"
    singularity:
        "docker://biocontainers/bowtie2"
    threads: 10
    resources:
        mem_mb=100000
    shell:
        "bowtie2-build {input[0]} {input[0]} ; "
        "bowtie2 -p 10 -q --no-unal -k 20 -x {input[0]} -1 {input[1]} -2 {input[2]} 2>{output[0]} {output[1]}"