library('maps')

# dat = read.csv('1989.csv')
# save(dat, file = 'dat.rda')

# load('dat.rda')
# airports = read.csv('airports.csv')
# big.airports = 
#   attributes(
#     sort(
#       table(dat$Dest), decreasing = TRUE))$dimnames[[1]][1:30]
# big.airports = sort(big.airports)
# airports = airports[airports$iata %in% big.airports,]
# dat = dat[dat$Origin %in% big.airports & 
#             dat$Dest %in% big.airports, 
#           -c(1,11,14,20:21,23,25:29)]
# dat = droplevels(dat)
# levels(dat$UniqueCarrier)[8] = 'PA'
# save(dat, airports, big.airports, file = 'dat2.rda')

load('dat2.rda')

# svg('airports.svg')
# map('state', bg = 'white', col = 'grey')
# points(airports$long, airports$lat, col = 'blue', pch = 16)
# dev.off()
