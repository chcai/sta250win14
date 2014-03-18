levels(dat$UniqueCarrier)[8] = 'PA'
# tmp = split(dat, dat$Origin)
# tmp2 = split(dat, dat$Dest)

sapply(1:length(big.airports), function(i) 
{
  med = by(tmp[[i]]$ArrDelay, tmp[[i]]$UniqueCarrier, 
           median, na.rm = TRUE)
  med = med[!is.na(med)]
  med.dest = by(tmp2[[i]]$ArrDelay, tmp2[[i]]$UniqueCarrier, 
           median, na.rm = TRUE)
  med.dest = med.dest[!is.na(med.dest)]
  png(paste0('plots/', names(tmp)[i], '.png'))
  plot(med, 
       type = 'b', 
       ylim = c(-10, 35), 
       xaxt = 'n', 
       xlab = 'Carrier', 
       ylab = 'Median Arrival Delay (Mins)', 
       main = 'Median Arrival Delays by Carrier')
  points(med.dest, type = 'b', col = 'blue')
  axis(1, at = c(1:length(med)), 
       labels = attributes(med)$dimnames[[1]])
  legend('topleft', 
         legend = c(paste0('Flights from ', names(tmp)[i]), 
                    paste0('Flights to ', names(tmp)[i])), 
         col = c('black', 'blue'), 
         lty = 1)
  dev.off()
})
