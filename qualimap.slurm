#!/bin/bash
#SBATCH -A bme4350
#SBATCH -p instructional
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=10:00:00
#SBATCH --mem=64GB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jdc7uq@virginia.edu

DATA=/scratch/$USER/project/ADstaroutput
OUTDIR=/scratch/$USER/project/ADqualimap
mkdir -p $OUTDIR

unset DISPLAY

FILES1=($(ls -1 $DATA/*ByCoord.out.bam))
file1="${FILES1[$SLURM_ARRAY_TASK_ID]}"

module purge
module load gcc qualimap

qualimap rnaseq -a proportional -bam $file1 -gtf /scratch/$USER/hg38_gencode_v44/gencode.v44.primary_assembly.annotation.gtf -outdir $OUTDIR/$SLURM_ARRAY_TASK_ID -p strand-specific-reverse --java-mem-size=32G