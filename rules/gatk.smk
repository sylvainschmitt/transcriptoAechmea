rule gatk:
    input:
        "results/super/trinity_genes.fasta",
        "results/super/variants/x.md.bam"
    output:
        "results/super/variants/output.vcf",
        "results/super/variants/output.filtered.vcf"
    log:
        "results/logs/gatk.log"
    benchmark:
        "results/benchmarks/gatk.benchmark.txt"
    singularity:
        "docker://broadinstitute/gatk:4.2.6.1"
    threads: 30
    resources:
        mem_mb=150000
    shell:
        "gatk HaplotypeCaller --java-options \"-Xmx150G -Xms1G" -R {input[0]} -I {input[1]} "
        "-dont-use-soft-clipped-bases -stand-call-conf 20.0 -V {output[0]} ;"
        "gatk VariantFiltration --java-options \"-Xmx150G -Xms1G" -R {input[0]} -V {output[0]} "
        "-window 35 -cluster 3 --filter-name FS -filter \"FS > 30.0\" "
        "--filter-name QD -filter \"QD < 2.0\" -O {output[1]}"
        