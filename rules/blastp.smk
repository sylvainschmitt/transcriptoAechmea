rule blastp:
    input:
        "results/annotation/transdecoder/aechmea.fa.transdecoder.pep",
        "results/annotation/db/uniprot_sprot.pep"
    output:
        "results/annotation/blastp/blastp.outfmt6"
    log:
        "results/logs/blastp.log"
    benchmark:
        "results/benchmarks/blastp.benchmark.txt"
    singularity:
        "docker://ncbi/blast"
    threads: 15
    shell:
        "blastp -db {input[1]} -query {input[0]} -num_threads {threads} -max_target_seqs 1 -outfmt 6 > {output}"
        