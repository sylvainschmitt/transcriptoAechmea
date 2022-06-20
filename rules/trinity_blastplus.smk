rule trinity_blastplus:
    input:
        "data/uniprot_sprot.fa",
        "results/transcriptome/aechmea.fa",
        "results/quality/full_length/blastx.outfmt6"
    output:
        "results/quality/full_length/blastx.outfmt6.hist"
    log:
        "results/logs/trinity_blastplus.log"
    benchmark:
        "results/benchmarks/trinity_blastplus.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/analyze_blastPlus_topHit_coverage.pl {input[2]} {input[1]} {input[0]}"