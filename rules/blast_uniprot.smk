rule blast_uniprot:
    input:
        "data/uniprot_sprot.fa",
        "results/transcriptome/aechmea.fa"
    output:
        "results/quality/full_length/blastx.outfmt6"
    log:
        "results/logs/blast_uniprot.log"
    benchmark:
        "results/benchmarks/blast_uniprot.benchmark.txt"
    singularity:
        "docker://ncbi/blast"
    threads: 10
    resources:
        mem_mb=100000
    shell:
        "makeblastdb -in {input[0]} -dbtype prot ; "
        "blastx -query {input[1]} -db {input[0]} -out {output}"
        " -evalue 1e-20 -num_threads {threads} -max_target_seqs 1 -outfmt 6"