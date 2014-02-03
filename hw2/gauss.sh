#!/bin/bash -l

module load R

#SBATCH --job-name=chcai

#SARRAY --range=1-81

#SBATCH -o dump/conv_%j.out
#SBATCH -e dump/conv_%j.err

srun R --vanilla --no-save --args ${SLURM_ARRAYID} < gauss.R