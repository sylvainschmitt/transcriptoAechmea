rule bowtie2_reads:
    input:
        "results/transcriptome/aechmea.fa",
        left=expand("{data}/{lib}_R1_001.fastq.gz", data=config["data"], lib=config["lib_test"]),
        right=expand("{data}/{lib}_R2_001.fastq.gz", data=config["data"], lib=config["lib_test"])
    output:
         temp("results/quality/reads_reps/left.fa"),
         temp("results/quality/reads_reps/right.fa"),
         "results/quality/reads_reps/align_stats.txt",
         temp("results/quality/reads_reps/bowtie2.sam")

    log:
        "results/logs/bowtie2_reads.log"
    benchmark:
        "results/benchmarks/bowtie2_reads.benchmark.txt"
    singularity:
        "docker://biocontainers/bowtie2:v2.4.1_cv1"
    threads: 30
    resources:
        mem_mb=100000
    params:
        left_str=lambda wildcards, input: " ".join(input.left),
        right_str=lambda wildcards, input: " ".join(input.right)
    shell:
        "zcat {params.left_str} > {output[0]} ; "
        "zcat {params.right_str} > {output[1]} ; "
        "bowtie2-build {input[0]} {input[0]} ; "
        "bowtie2 -p {threads} -q --no-unal -k 20 -x {input[0]} -1 {output[0]} -2 {output[1]} -S {output[3]} > {output[2]}"
        
