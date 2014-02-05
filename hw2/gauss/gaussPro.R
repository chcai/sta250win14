## this script reads in the concatenated freq table, 
## sums the counts for any duplicated arrival delays, 
## and calculates the desired statistics

library(Hmisc) ## wtd.stats()

table. = read.table('ctable.txt')
## sum counts for any duplicated arrival delays; 
## i.e. merge entries
counts = by(table.[,2], table.[,1], sum, simplify = FALSE)
## force by object into vector
counts = as.numeric(counts)
## by() sorts arrival delays
arr.delay = sort(unique(table.[,1]))

## get stats
mu = wtd.mean(arr.delay, counts)
std = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
med = quantiles[3]

## save results and system info
results1 = list(time = 2.5*60, 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                ram = '768gb', 
                num.processors = 12*32, 
                cpu.mhz = 1400, 
                cpu.cores = 8, 
                os = 'Ubuntu 12.04')
save(results1, file = 'results1.rda')
