rule star:
    input:
        fa="results/super/trinity_genes.fasta",
        left=expand("{data}/{lib}_R1_001.fastq.gz", data=config["data"], lib=config["libraries"]),
        right=expand("{data}/{lib}_R2_001.fastq.gz", data=config["data"], lib=config["libraries"])
    output:
        "results/super/variants/x.bam"
    log:
        "results/logs/star.log"
    benchmark:
        "results/benchmarks/star.benchmark.txt"
    singularity:
        "docker://mgibio/star"
    threads: 30
    resources:
        mem_mb=150000
    params:
        left_str=lambda wildcards, input: ",".join(input.left),
        right_str=lambda wildcards, input: ",".join(input.right),
        max_mem = lambda wildcards, resources: int(resources.mem_mb * 1024 * 1024),
        dir_in="results/super/",
        dir_out="results/super/variants/"
    shell:
        "STAR --runThreadN {threads} --genomeDir {params.dir_in} "
        "--runMode alignReads --twopassMode Basic --alignSJDBoverhangMin 10 "
        "--outSAMtype BAM SortedByCoordinate --limitBAMsortRAM 218601532341 "
        "--readFilesIn {params.left_str}, {params.right_str} "
        "--outFileNamePrefix {params.dir_out}"
        