rule rename_gff:
    input:
        signalp_gff = "results/annotation/signalp/signalp.out.gff3",
        ids = "results/annotation/signalp/aechmea.fa.transdecoder.pep.ids"
    output:
        signalp_renamed_gff = "results/annotation/signalp/signalp.renamed.out"
    log:
        "results/logs/rename_gff.log"
    benchmark:
        "results/benchmarks/rename_gff.benchmark.txt"
    script:
        "../scripts/rename_gff.R"
        