rule rename_fasta_headers:
    input:
        transdecoder_results = "results/annotation/transdecoder/aechmea.fa.transdecoder.pep"
    output:
        renamed_transdecoder = "results/annotation/signalp/aechmea.fa.transdecoder.pep.renamed",
        ids = "results/annotation/signalp/aechmea.fa.transdecoder.pep.ids"
    log:
        "results/logs/rename_fasta_headers.log"
    benchmark:
        "results/benchmarks/rename_fasta_headers.benchmark.txt"
    script:
        "../scripts/rename_fasta_headers.py"
        