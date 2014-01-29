library(Hmisc)

arg = 1
direc.out = 'output'
file.out = paste0(direc.out, '/table', 1000+arg, '.txt')

table.i2 = read.table(file.out)
table.i2 = as.matrix(table.i2)

wtd.mean(table.i2[,1], table.i2[,2])
