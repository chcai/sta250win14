## this script reads in the concatenated freq table, 
## i.e. the outputs from MapReduce (java)
## and calculates the desired statistics

library(Hmisc) ## wtd.stats()

table. = read.table('part-r-00000')
counts = as.integer(table.[,2])
arr.delay = as.integer(table.[,1])

## get stats
mu = wtd.mean(arr.delay, counts)
std = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
med = quantiles[3]

## save results and system info
results3 = list(time = 7*60, 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                hadoop.version = '1.2.1')
save(results3, file = 'results3.rda')
