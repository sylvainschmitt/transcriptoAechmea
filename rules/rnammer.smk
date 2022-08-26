rule rnammer:
    input:
        "results/transcriptome/aechmea.fa",
        "/home/ECOFOG/sylvain.schmitt/Documents/tools/rnammer-1.2.src/rnammer"
    output:
        "results/annotation/rnammer/Trinity.fasta.rnammer.gff"
    log:
        "results/logs/rnammer.log"
    benchmark:
        "results/benchmarks/rnammer.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        "/usr/local/bin/RnammerTranscriptome.pl --transcriptome {input[0]} --path_to_rnammer {input[1]} ;"
        