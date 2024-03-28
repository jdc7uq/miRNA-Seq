#!/bin/bash
#SBATCH -A bme4350
#SBATCH -p instructional
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=12:00:00
#SBATCH --mem=64GB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jdc7uq@virginia.edu


DATA=/scratch/$USER/project/ADstaroutput

FILES=($(ls -1 $DATA/*Aligned.toTranscriptome.out.bam))
FILE_INPUT=${FILES[$SLURM_ARRAY_TASK_ID]}


OUTDIR=/scratch/$USER/project/ADrsem/$(basename $FILE_INPUT)
mkdir -p $OUTDIR

module purge
module load gcc/7.1.0 openmpi/3.1.4 rsem

rsem-calculate-expression --alignments -p 10 $FILE_INPUT /scratch/$USER/project/project_genome_rsem/RSEMref $OUTDIR




