## this script reads in the concatenated freq table, 
## i.e. the outputs from MapReduce
## and calculates the desired statistics

library(Hmisc) ## wtd.stats()

## values are comma seperated
table. = read.table('output/part-00000', sep = ',')
counts = as.integer(table.[,2])
arr.delay = as.integer(table.[,1])

## get stats
mu = wtd.mean(arr.delay, counts)
std = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
med = quantiles[3]

## save results and system info
results2 = list(time = 13.5*60, 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                hadoop.version = '1.2.1')
save(results2, file = 'results2.rda')
