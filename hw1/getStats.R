get.stats.fun = function(tables) {
  table. = do.call(rbind, tables)
  
  counts = by(table.[,1], table.[,2], sum, simplify = FALSE)
  counts = as.numeric(counts)
  arr.delay = sort(unique(table.[,2]))
  
  mu = wtd.mean(arr.delay, counts)
  std = sqrt(wtd.var(arr.delay, counts))
  quantiles = wtd.quantile(arr.delay, counts)
  med = quantiles[3]
  
  results = c(mean = mu, median = med, sd = std)
  list(results = results, quantiles = quantiles)
}
