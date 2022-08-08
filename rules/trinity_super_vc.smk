rule trinity_super_vc:
    input:
        fa="results/super/trinity_genes.fasta",
        gtf="results/super/trinity_genes.gtf",
        reads="data/sample.tsv"
    output:
        directory("results/super/variants")
    log:
        "results/logs/trinity_super_vc.log"
    benchmark:
        "results/benchmarks/trinity_super_vc.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    threads: 30
    resources:
        mem_mb=150000
    params:
        max_mem = lambda wildcards, resources: int(resources.mem_mb * 1024 * 1024)
    shell:
        "$TRINITY_HOME/Analysis/SuperTranscripts/AllelicVariants/run_variant_calling.py "
        "--st_fa {input.fa} "
        "--st_gtf {input.gtf} "
        "-S {input.reads} "
        "-o {output} "
        "-t {threads} "
        "-m 218601532341" # hardcoded, volume asked by the soft 
        