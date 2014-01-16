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
counts = by(table.[,1], table.[,2], sum, simplify=FALSE)
counts = as.numeric(counts)
# by() sorts the arrival delays
arr.delay = sort(unique(table.[,2]))

# get the statistics
mean = wtd.mean(arr.delay, counts)
sd = sqrt(wtd.var(arr.delay, counts))
quantiles = wtd.quantile(arr.delay, counts)
median = quantiles[3]
