rule trinity:
    input:
        left=expand("{data}/{lib}_R1_001.fastq.gz", data=config["data"], lib=config["libraries"]),
        right=expand("{data}/{lib}_R2_001.fastq.gz", data=config["data"], lib=config["libraries"])
    output:
        directory("results/transcriptome/trinity"),
        "results/transcriptome/aechmea.fa",
        "results/transcriptome/aechmea.fa.gene_trans_map"
    log:
        "results/logs/trinity.log"
    benchmark:
        "results/benchmarks/trinity.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
        # "https://data.broadinstitute.org/Trinity/TRINITY_SINGULARITY/trinityrnaseq.v2.14.0.simg"    
    threads: 30
    resources:
        mem_mb=100000
    params:
        left_str=lambda wildcards, input: ",".join(input.left),
        right_str=lambda wildcards, input: ",".join(input.right),
        max_mem = lambda wildcards, resources: int(resources.mem_mb / 1000)
    shell:
        "Trinity --seqType fq --left {params.left_str} --right {params.right_str} --max_memory {params.max_mem}G --CPU {threads} --output {outpu[0]} ; "
        "mv {params.dir}trinity.Trinity.fasta {outpu[1]} ;"
        "mv {params.dir}trinity.Trinity.fasta.gene_trans_map {outpu[2]}"