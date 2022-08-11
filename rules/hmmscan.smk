rule hmmscan:
    input:
        "results/annotation/transdecoder/aechmea.fa.transdecoder.pep",
        "results/annotation/db/Pfam-A.hmm.gz"
    output:
        "results/annotation/hmmer/TrinotatePFAM.out"
    log:
        "results/logs/hmmscan.log"
    benchmark:
        "results/benchmarks/hmmscan.benchmark.txt"
    singularity:
        "docker://dockerbiotools/hmmer:latest"
    threads: 15
    shell:
        "hmmscan --cpu {threads} --domtblout {output} {input[1]} {input[0]} > {log}"
        