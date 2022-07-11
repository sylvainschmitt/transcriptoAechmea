rule samtools_view:
    input:
        "results/quality/reads_reps/bowtie2.sam"
    output:
        "results/quality/reads_reps/bowtie2.coordSorted.bam"
    log:
        "results/logs/samtools_view.log"
    benchmark:
        "results/benchmarks/samtools_view.benchmark.txt"
    singularity:
        "docker://biocontainers/samtools:v1.9-4-deb_cv1"
    shell:
        "samtools view -Sb {input} | samtools sort -o {output}"