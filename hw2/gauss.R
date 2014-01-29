direc = 'data'
direc.out = 'output'

command.args = commandArgs(TRUE)
arg = as.numeric(command.args[1])

files = list.files(direc)
file.i = paste0(direc, '/', files[arg])

dat = read.csv(file.i, colClasses = 'character')

if(arg <= 21) col.name = 'ArrDelay' else col.name = 'ARR_DELAY'

table.i = table(as.integer(dat[,col.name]))

file.out = paste0(direc.out, '/table', 1000+arg, '.txt')
write.table(table.i, file = file.out, quote = FALSE, 
            row.names = FALSE, col.names = FALSE)
