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
        "docker://gravelc/trinotate_web"
    threads: 1
    shell:
        "/software/trinotate/Trinotate-3.0.1/util/rnammer_support/RnammerTranscriptome.pl --transcriptome {input[0]} --path_to_rnammer {input[1]} ;"
        