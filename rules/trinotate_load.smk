rule trinotate_load:
    input:
        fasta = "results/transcriptome/aechmea.fa",
        gene_trans_map = "results/transcriptome/aechmea.fa.gene_trans_map",
        transdecoder = "results/annotation/transdecoder/aechmea.fa.transdecoder.pep",
        blastx = "results/annotation/blastx/blastx.outfmt6",
        blastp = "results/annotation/blastp/blastp.outfmt6",
        signalp = "results/annotation/signalp/signalp.renamed.out",
        tmhmm = "results/annotation/tmhmm/tmhmm.out", 
        hmmer = "results/annotation/hmmer/TrinotatePFAM.out",
        rnammer = "results/annotation/rnammer/Trinity.fasta.rnammer.gff",
        db = "results/annotation/db/aechmea.sqlite"
    output:
        "results/annotation/aechmea.sqlite"
    log:
        "results/logs/trinotate_load.log"
    benchmark:
        "results/benchmarks/trinotate_load.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        'cp {input.db} {output} ; '
        'Trinotate {output} init --gene_trans_map {input.gene_trans_map} '
        '--transcript_fasta {input.fasta} --transdecoder_pep {input.transdecoder} ; '
        'Trinotate {output} LOAD_swissprot_blastx {input.blastx} ; '
        'Trinotate {output} LOAD_swissprot_blastp {input.blastp} ; '
        'Trinotate {output} LOAD_pfam {input.hmmer} ; '
        'Trinotate {output} LOAD_tmhmm {input.tmhmm} ; '
        'Trinotate {output} LOAD_signalp {input.signalp} ; '
        'Trinotate {output} LOAD_rnammer {input.rnammer}'
        