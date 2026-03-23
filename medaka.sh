#!/bin/bash

#Submit this script with: sbatch thefilename

#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16   # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=100G
#SBATCH -p #node name
#SBATCH -J "nextflow_medaka"   # job name
#SBATCH --mail-user=# email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END

module purge
module load go/1.18.3
module load singularity/3.8.7
module load nextflow/25.10.4

nextflow -C nextflow.config run medaka.nf -resume
