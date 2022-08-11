rule trinotate_db:
    output:
        "results/annotation/db/aechmea.sqlite",
        "results/annotation/db/uniprot_sprot.pep",
        "results/annotation/db/Pfam-A.hmm.gz"
    log:
        "results/logs/trinotate_db.log"
    benchmark:
        "results/benchmarks/trinotate_db.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    params:
        wd="results/annotation/db/"
    shell:
        'cd {params.wd} ; '
        '/usr/local/bin/Build_Trinotate_Boilerplate_SQLite_db.pl  aechmea ; '
        'makeblastdb -in uniprot_sprot.pep -dbtype prot ; '
        'gunzip Pfam-A.hmm.gz ; '
        'hmmpress Pfam-A.hmm'
        