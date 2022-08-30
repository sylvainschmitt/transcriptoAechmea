rule trinity_gene_length:
    input:
        "results/transcriptome/aechmea.fa",
        "results/transcriptome/aechmea.fa.gene_trans_map",
        "results/quantification/RSEM.isoform.TMM.EXPR.matrix"
    output:
        "results/transcriptome/aechmea.fa_seq_lens",
        "results/transcriptome/aechmea.gene_lengths.txt"
    log:
        "results/logs/trinity_gene_length.log"
    benchmark:
        "results/benchmarks/trinity_gene_length.benchmark.txt"
    singularity:
        "/home/ECOFOG/sylvain.schmitt/Documents/singularity/trinity.simg"
    shell:
        "$TRINITY_HOME/util/misc/fasta_seq_length.pl {input[0]} > {output[0]} ; "
        "$TRINITY_HOME/util/misc/TPM_weighted_gene_length.py "
        "--gene_trans_map {input[1]} "
        "--trans_lengths {output[0]} "
        "--TPM_matrix {input[2]} > {output[1]} "