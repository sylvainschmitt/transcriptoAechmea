rule busco:
    input:
        "results/transcriptome/aechmea.fa"
    output:
        directory("results/quality/aechmea_busco")
    log:
        "results/logs/busco.log"
    benchmark:
        "results/benchmarks/busco.benchmark.txt"
    singularity:
        "docker://ezlabgva/busco:v5.2.2_cv2"
    threads: 10
    resources:
        mem_mb=100000
    shell:
        "busco -i {input} -o aechmea_busco -m genome -l viridiplantae --cpu {threads} --download_path tmp ; "
        "mv aechmea_busco {output} "