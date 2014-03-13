tmp = split(dat, dat$Origin, drop = TRUE)

sapply(1:30, function(i) 
{
  med = by(tmp[[i]]$ArrDelay, tmp[[i]]$UniqueCarrier, 
           median, na.rm = TRUE)
  med = med[!is.na(med)]
  png(paste0('plots/', names(tmp)[i], '.png'))
  plot(med, 
       type = 'b', 
       ylim = c(-10, 20), 
       xaxt = 'n', 
       xlab = 'Airline', 
       ylab = 'Median Arrival Delay (Mins)', 
       main = paste0('Flights from ', names(tmp)[i]))
  axis(1, at = c(1:length(med)), 
       labels = attributes(med)$dimnames[[1]])
  dev.off()
})