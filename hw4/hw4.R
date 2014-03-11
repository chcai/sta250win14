# dat = read.csv('1987.csv')
# save(dat, file = 'dat.rda')
load('dat.rda')
airports = read.csv('airports.csv')

big.airports = 
  attributes(
    sort(
      table(dat$Dest), decreasing = TRUE))$dimnames[[1]][1:30]
airports[airports$iata %in% big.airports,]
