rule trinity_strand:
    input:
        "results/quality/reads_reps/bowtie2.coordSorted.bam"
    output:
        "results/quality/reads_reps/bowtie2.coordSorted.bam.strand.stats"
    log:
        "results/logs/trinity_strand.log"
    benchmark:
        "results/benchmarks/trinity_strand.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/misc/examine_strand_specificity.pl {input}"
        