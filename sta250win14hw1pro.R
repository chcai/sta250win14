files = list.files('tables')

file.i = paste0('tables/', files[i])
table. = read.table(file.i)

library(Hmisc)

table. = read.table('ctable.txt')
bla = by(table.[,1], table.[,2], sum, simplify=FALSE)
sort(unique(table.[,2]))

wtd.mean(table.[,2], table.[,1])
sqrt(wtd.var(table.[,2], table.[,1]))
