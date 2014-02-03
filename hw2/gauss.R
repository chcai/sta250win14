## this script reads one csv file and writes an arrival delays 
## frequency table to a txt file.
## to be used on a cluster with slurm

## directory containing (only) the csv files to be processed
direc = 'data/'
## output directory where the freq tables will go
direc.out = 'output/'

## read in command line arguments
command.args = commandArgs(TRUE)
## get array job number
arg = as.numeric(command.args[1])

## if i-th job, read the i-th file in direc
files = list.files(direc)
file.i = paste0(direc, files[arg])

dat = read.csv(file.i, colClasses = 'character')

## after 2007, data format changes
if(arg <= 21) col.name = 'ArrDelay' else col.name = 'ARR_DELAY'

## get freq table and write to txt file
table.i = table(as.integer(dat[,col.name]))

## if we want the freq table files to be listed in order, 
## start with table1001.txt
file.out = paste0(direc.out, 'table', 1000+arg, '.txt')
write.table(table.i, file = file.out, quote = FALSE, 
            row.names = FALSE, col.names = FALSE)
