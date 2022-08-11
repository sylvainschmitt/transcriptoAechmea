rule blastx:
    input:
        "results/transcriptome/aechmea.fa",
        "results/annotation/db/uniprot_sprot.pep"
    output:
        "results/annotation/blastx/blastx.outfmt6"
    log:
        "results/logs/blastx.log"
    benchmark:
        "results/benchmarks/blastx.benchmark.txt"
    singularity:
        "docker://ncbi/blast"
    threads: 15
    shell:
        "blastx -db {input[1]} -query {input[0]} -num_threads {threads} -max_target_seqs 1 -outfmt 6 > {output}"
        