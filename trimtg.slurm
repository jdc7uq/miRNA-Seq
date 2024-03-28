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



DATA=/scratch/$USER/project/patients
OUTDIR=/scratch/$USER/project/patients/TGtrail
mkdir -p $OUTDIR

FILES1=($(ls -1 $DATA/*.fastq.gz))

file1="${FILES1[$SLURM_ARRAY_TASK_ID]}"

module purge
module load trimgalore
module load fastqc

trim_galore --quality 28 --small_rna --length 22 --fastqc --output_dir $OUTDIR $file1

