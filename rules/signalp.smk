rule signalp:
    input:
        "results/annotation/signalp/aechmea.fa.transdecoder.pep.renamed"
    output:
        "results/annotation/signalp/signalp.out.gff3"
    log:
        "results/logs/signalp.log"
    benchmark:
        "results/benchmarks/signalp.benchmark.txt"
    singularity:
        "docker://streptomyces/signalp"
    threads: 1
    shell:
        "signalp -fasta {input} -format short -org euk -gff3 -prefix {output} "
        