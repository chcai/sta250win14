# R CMD INSTALL -l "Rlib" FastCSVSample
# export R_LIBS="Rlib"
# .libPaths()

library(FastCSVSample) # csvSample()
library(Hmisc) # wtd.mean(), wtd.var(), wtd.quantile()

time. = system.time({
  n = 10
  
  files = list.files('data')
  tables = list(); length(tables) = length(files)
  
  #1:length(files)
  for(i in 21:22) {
    file.i = paste0('data/', files[i])
    print(file.i)
    if(i <= 21) col.num = 15 else col.num = 45
    dat = csvSample(file.i, n)
    dat = strsplit(dat, ',')
    dat = t(as.data.frame(dat))
    table.i = table(as.integer(dat[,col.num]))
    counts = as.numeric(table.i)
    arr.delay = as.integer(attributes(table.i)$dimnames[[1]])
    tables[[i]] = cbind(counts, arr.delay)
  }
  
  save(tables, file = 'tables.rda')
  
  table. = do.call(rbind, tables)
  
  counts = by(table.[,1], table.[,2], sum, simplify = FALSE)
  counts = as.numeric(counts)
  arr.delay = sort(unique(table.[,2]))
  
  mu = wtd.mean(arr.delay, counts)
  std = sqrt(wtd.var(arr.delay, counts))
  quantiles = wtd.quantile(arr.delay, counts)
  med = quantiles[3]
})

results3 = list(time = time., 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                ram = '256gb', 
                cpu.mhz = 2899.863, 
                num.processors = 32, 
                cpu.cores = 8, 
                os = 'SL 6.3')
save(results3, file = 'results3.rda')
