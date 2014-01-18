library(Hmisc) # wtd.mean(), wtd.var(), wtd.quantile()

time. = system.time({
  files = list.files('data')
  tables = list(); length(tables) = length(files)
  
  for(i in 1:length(files)) {
    file.i = paste0('data/', files[i])
    if(i <= 21) col.name = 'ArrDelay' else col.name = 'ARR_DELAY'
    dat = read.csv(file.i, colClasses = 'character')
    table.i = table(as.integer(dat[,col.name]))
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

results2 = list(time = time., 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                system = Sys.info(), 
                session = sessionInfo(), 
                ram = '256gb', 
                cpu.mhz = 2899.863, 
                num.processors = 32, 
                cpu.cores = 8, 
                os = 'SL 6.3')
save(results2, file = 'results2.rda')
