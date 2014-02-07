#!/bin/sh

#SBATCH --job-name=gaussPro

module load R

srun R --vanilla < gaussPro.R