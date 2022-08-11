rule signalp:
    input:
        "results/annotation/signalp/aechmea.fa.transdecoder.pep.renamed"
    output:
        "results/annotation/signalp/signalp.out"
    log:
        "results/logs/signalp.log"
    benchmark:
        "results/benchmarks/signalp.benchmark.txt"
    singularity:
        # https://github.com/biocorecrg/interproscan_docker    
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/iprscan.sif"
    threads: 1
    shell:
        "signalp -f short -n {output} {input}"
        