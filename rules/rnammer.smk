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
        "docker://quay.io/biocontainer/trinotate"
    threads: 1
    shell:
        "$TRINOTATE_HOME/util/rnammer_support/RnammerTranscriptome.pl ---transcriptome {input[0]} --path_to_rnammer {input[1]} ;"
        