library(Hmisc)

table. = read.table('ctable.txt')
counts = by(table.[,2], table.[,1], sum, simplify = FALSE)
counts = as.numeric(counts)
arr.delay = sort(unique(table.[,1]))

mu = wtd.mean(arr.delay, counts)
std = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
med = quantiles[3]
