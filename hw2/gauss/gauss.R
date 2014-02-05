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

## pre-2008 files (first 21 files) and post-2008 files 
## have different structures.
if(arg <= 21) {
  ## ignore all columns but arrival delays
  dat = read.csv(file.i, 
                 colClasses = c(rep('NULL', 14), 'character', 
                                rep('NULL', 14)))
} else {
  dat = read.csv(file.i, 
                 colClasses = c(rep('NULL', 42), 'character', 
                                rep('NULL', 67)))
}
  
## get freq table
table.i = table(as.integer(dat[[1]]))

## write freq table to txt file.
## if we want to make sure the freq table files 
## will be listed in order, 
## start with table1001.txt
file.out = paste0(direc.out, 'table', 1000+arg, '.txt')
write.table(table.i, file = file.out, quote = FALSE, 
            row.names = FALSE, col.names = FALSE)
