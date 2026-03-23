#!/bin/bash

#Submit this script with: sbatch thefilename


#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --cpus-per-task=16   # number of CPU per task
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=200G
#SBATCH -p #node name
#SBATCH -J "alignment"   # job name
#SBATCH --mail-user=# email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END

module purge
module load go/1.18.3
module load singularity/3.8.7

minimap2="path/to/singularity/image"
samtools="path/to/singularity/image"

singularity exec $minimap2 bash -c "minimap2 -ax map-ont --secondary=no -t 16 polished_with_racon_assembly.fa ONT_reads.fastq > aligned.sam"
singularity exec $samtools bash -c "samtools sort -o aligned_to_racon.bam aligned.sam && samtools index aligned_to_racon.bam && rm aligned.sam"
