rule trinity:
    input:
        left=expand("{data}/{lib}_R1_001.fastq.gz", data=config["data"], lib=config["libraries"]),
        right=expand("{data}/{lib}_R2_001.fastq.gz", data=config["data"], lib=config["libraries"])
    output:
        directory("results/trinity")
    log:
        "results/logs/trinity.log"
    benchmark:
        "results/benchmarks/trinity.benchmark.txt"
    singularity:
        "https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg"
    threads: 4
    resources:
        mem_mb=10000
    params:
        left_str=lambda wildcards, input: ",".join(input.left),
        right_str=lambda wildcards, input: ",".join(input.right),
        max_mem = lambda wildcards, resources: int(resources.mem_mb / 1000)
        # input_str_left = " --left " + ",".join(left)
        # input_str_right = " --right " + ",".join(right)
    shell:
        "Trinity --seqType fq --left {params.left_str} --right {params.right_str} --max_memory {params.max_mem}G --CPU {threads} --output {output}"