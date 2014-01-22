library(Hmisc) # wtd.mean(), wtd.var(), wtd.quantile()

# ctable.txt should be the concatenated freq table
# for all the files
# with non-integer rows removed
# i.e. name of arrival delay col, NA, and empty entries
table. = read.table('ctable.txt')
# while ctable.txt is concatenated, 
# it is not merged across files
# i.e. there may be (and probably will be) >1 rows of counts
# for arrival delay 0, etc.
# use by() to merge counts for same arrival times
counts = by(table.[,1], table.[,2], sum, simplify = FALSE)
counts = as.numeric(counts)
# by() sorts the arrival delays
arr.delay = sort(unique(table.[,2]))

# get the statistics
mu = wtd.mean(arr.delay, counts)
std = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
med = quantiles[3]

load('time.rda')

# save the results and system info
results1 = list(time = time., 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                ram = '242gb', 
                num.processors = 32, 
                cpu.mhz = 2899.863, 
                cpu.cores = 8, 
                os = 'SL 6.3')
save(results1, file = 'results1.rda')
