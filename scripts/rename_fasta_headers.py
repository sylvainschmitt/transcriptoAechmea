#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# from https://github.com/sarahinwood/trinotate-pipeline/blob/master/trinotate_pipeline/src/rename_fasta_headers.py

from Bio import SeqIO
import csv

# snakemake files
transdecoder_results = snakemake.input['transdecoder_results']
renamed_transdecoder = snakemake.output['renamed_transdecoder']
ids = snakemake.output['ids']

# read FASTA
records = list(SeqIO.parse(transdecoder_results, 'fasta'))

# declare dictionaries
pepid_to_id = {}

# rename records, keep map of new id to old id
i = 0
for rec in records:
    i += 1
    # store old values in dictionaries
    pepid = 'PEP' + str(i)
    pepid_to_id[pepid] = rec.id

    # replace values and rename
    rec.id = pepid
    rec.name = ''
    rec.description = ''

# generating list of new id to old id
result_lines = list([x, pepid_to_id[x]]
                    for x in pepid_to_id.keys())

# write id mapping to file
header = ['pepid', 'id']
with open(ids, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    writer.writerow(header)
    writer.writerows(result_lines)

# write renamed fasta
SeqIO.write(
    sequences=records,
    handle=renamed_transdecoder,
    format='fasta')
