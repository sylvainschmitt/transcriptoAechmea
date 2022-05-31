#!/bin/bash
#SBATCH --time=96:00:00
#SBATCH -J hetre
#SBATCH -o hetre.%N.%j.out
#SBATCH -e hetre.%N.%j.err
#SBATCH --mem=5G
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL
####SBATCH -p unlimitq

# Environment
module purge
module load bioinfo/snakemake-5.25.0
module load system/singularity-3.7.3

# Variables
CONFIG=config/ressources.genologin.yaml
COMMAND="sbatch --cpus-per-task={cluster.cpus} --time={cluster.time} --mem={cluster.mem} -J {cluster.jobname} -o snake_subjob_log/{cluster.jobname}.%N.%j.out -e snake_subjob_log/{cluster.jobname}.%N.%j.err"
CORES=100
mkdir -p snake_subjob_log

# Workflow
snakemake -s Snakefile --use-singularity --singularity-args "\-\-bind /work/project/treemutation \-\-containall" -j $CORES --cluster-config $CONFIG --cluster "$COMMAND" --keep-going

## Session informations
echo '########################################'
echo 'Date:' $(date --iso-8601=seconds)
echo 'User:' $USER
echo 'Host:' $HOSTNAME
echo 'Job Name:' $SLURM_JOB_NAME
echo 'Job ID:' $SLURM_JOB_ID
echo 'Number of nodes assigned to job:' $SLURM_JOB_NUM_NODES
echo 'Nodes assigned to job:' $SLURM_JOB_NODELIST
echo 'Directory:' $(pwd)
echo '########################################'
