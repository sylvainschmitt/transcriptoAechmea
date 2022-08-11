rule transdecoder:
    input:
        "results/transcriptome/aechmea.fa",
        "results/transcriptome/aechmea.fa.gene_trans_map"
    output:
        "results/annotation/transdecoder/aechmea.fa.transdecoder.pep"
    log:
        "results/logs/transdecoder.log"
    benchmark:
        "results/benchmarks/transdecoder.benchmark.txt"
    singularity:
        "oras://registry.forgemia.inra.fr/gafl/singularity/transdecoder/transdecoder:latest"
    threads: 1
    params:
        dir="results/annotation/transdecoder"
    shell:
        "TransDecoder.LongOrfs -t {input[0]} --gene_trans_map {input[1]} -S -O {output} ; "
        "TransDecoder.Predict -t {input[0]} -O {output} "