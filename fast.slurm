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

DATA=/scratch/$USER/project/patients/NAD
OUTDIR=/scratch/$USER/project/patients/NAD
mkdir -p $OUTDIR

FILES1=($(ls -1 $DATA/ENCFF093LCA.fastq))
file1="${FILES1[$SLURM_ARRAY_TASK_ID]}"

module purge
module load fastqc
fastqc $file1 --outdir $OUTDIR --threads $SLURM_CPUS_PER_TASK