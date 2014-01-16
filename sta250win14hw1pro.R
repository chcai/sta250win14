library(Hmisc)

table. = read.table('ctable.txt')
counts = by(table.[,1], table.[,2], sum, simplify=FALSE)
counts = as.numeric(counts)
arr.delay = sort(unique(table.[,2]))

wtd.mean(arr.delay, counts)
sqrt(wtd.var(arr.delay, counts))
wtd.quantile(arr.delay, counts)
