#!/bin/bash -l

module load R

#SBATCH --job-name=chcai

# there are 81 csv files
#SARRAY --range=1-81

# Standard out and Standard Error output files
#SBATCH -o dump/conv_%j.out
#SBATCH -e dump/conv_%j.err

# Execute each of the jobs with a different index (the R script will then process
# this to do something different for each index):
srun R --vanilla --no-save --args ${SLURM_ARRAYID} < gauss.R