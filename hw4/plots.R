## split the data based on origin and dest airports
tmp = split(dat, dat$Origin)
tmp2 = split(dat, dat$Dest)

## separate plot for each airport
sapply(1:length(big.airports), function(i) 
{
  ## get median arrival delays by carrier
  med = by(tmp[[i]]$ArrDelay, tmp[[i]]$UniqueCarrier, 
           median, na.rm = TRUE)
  ## get rid of NA's
  med = med[!is.na(med)]
  ## repeat for dest
  med.dest = by(tmp2[[i]]$ArrDelay, tmp2[[i]]$UniqueCarrier, 
           median, na.rm = TRUE)
  med.dest = med.dest[!is.na(med.dest)]
  ## plot median arrival delays. 
  ## the plots will go to dir 'plots'
  png(paste0('plots/', names(tmp)[i], '.png'))
  plot(med, type = 'b', ylim = c(-10, 35), xaxt = 'n', 
       xlab = 'Carrier', 
       ylab = 'Median Arrival Delay (Mins)', 
       main = 'Median Arrival Delays by Carrier')
  points(med.dest, type = 'b', col = 'blue')
  ## add my own x axis; 
  ## add carrier names for tick labels
  axis(1, at = c(1:length(med)), 
       labels = attributes(med)$dimnames[[1]])
  ## add legend
  legend('topleft', 
         legend = c(paste0('Flights from ', names(tmp)[i]), 
                    paste0('Flights to ', names(tmp)[i])), 
         col = c('black', 'blue'), 
         lty = 1)
  dev.off()
})
