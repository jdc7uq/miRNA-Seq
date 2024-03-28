#!/bin/bash
#SBATCH -A bme4350
#SBATCH -p instructional
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --time=8:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jdc7uq@virginia.edu



DATA=/scratch/$USER/project/patients/AD_fastq

FILES=($(ls -1 $DATA/*trim.fastq))
FILE_INPUT=${FILES[$SLURM_ARRAY_TASK_ID]}

module purge
module load star gcc

STAR --genomeDir /scratch/$USER/project/project_genome_index --readFilesIn $FILE_INPUT --runThreadN 16 --sjdbGTFfile /scratch/$USER/project/genome_reference/ENCFF470CZH.gtf --alignEndsType EndToEnd --outFilterMismatchNmax 1 --outFilterMultimapScoreRange 0 --quantMode TranscriptomeSAM GeneCounts --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate --outFilterMultimapNmax 10 --outSAMunmapped Within --outFilterScoreMinOverLread 0 --outFilterMatchNminOverLread 0 --outFilterMatchNmin 16 --alignSJDBoverhangMin 1000 --alignIntronMax 1 --outFileNamePrefix "/scratch/$USER/project/ADstaroutput/$SLURM_ARRAY_TASK_ID"
