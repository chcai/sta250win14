  
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
