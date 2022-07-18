rule trinity_super_de:
    input:
        "results/super/trinity_genes.fasta",
        "results/super/trinity_genes.gtf",
        "data/sample.tsv"
    output:
        "results/super/expression/DTU.dexseq.results.dat"
    log:
        "results/logs/trinity_super_de.log"
    benchmark:
        "results/benchmarks/trinity_super_de.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/Analysis/SuperTranscripts/DTU/dexseq_wrapper.pl "
        "--genes_fasta {input[0]} "
        "--genes_gtf {input[1]} "
        "--samples_file {input[2]} "
        "--out_prefix DTU --aligner STAR"
        