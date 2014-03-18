library('maps')

## save the data so we don't need to read it in everytime. 
# get the 30 biggest airports; 
# sort them for ease. 
# subset the data; 
# we only want the rows with the 30 biggest airports; 
# and some columns are all NA'S, so get rid of them. 
# drop the levels that aren't present anymore. 
# change carrier 'PA (1)' to 'PA'; 
# there is no 'PA', 'PA (2)', or anything similar. 
## save these objects for ease.

# dat = read.csv('1989.csv')
# save(dat, file = 'dat.rda')
# 
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

## make svg plot of US map with the 30 airports
svg('airports.svg')
map('state', bg = 'white', col = 'grey')
points(airports$long, airports$lat, col = 'blue', pch = 16)
dev.off()
