configfile: "config/config.yml"

rule all:
   input:
       "results/trinity"

# Rules #
include: "rules/trinity.smk"
