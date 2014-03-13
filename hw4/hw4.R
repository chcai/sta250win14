library('RgoogleMaps')

# dat = read.csv('1989.csv')
# save(dat, file = 'dat.rda')

# load('dat.rda')
# airports = read.csv('airports.csv')
# big.airports = 
#   attributes(
#     sort(
#       table(dat$Dest), decreasing = TRUE))$dimnames[[1]][1:30]
# airports = airports[airports$iata %in% big.airports,]
# dat = dat[dat$Origin %in% big.airports & 
#             dat$Dest %in% big.airports, 
#           -c(1,11,14,20:21,23,25:29)]
# dat = droplevels(dat)
# save(dat, airports, big.airports, file = 'dat2.rda')

load('dat2.rda')

markers = cbind(airports$lat, airports$long, rep('small', 30), 
                rep('red', 30), rep('', 30))
colnames(markers) = c("lat", "lon", "size", "col", "char")

svg('airports.svg')
map = GetMap('United States', zoom = 4, markers = markers)
PlotArrowsOnStaticMap(map, 33.64044, -84.42694, 36.12448, -86.67818)
dev.off()

# PlotArrowsOnStaticMap(map, 
#                       airports$lat[1:2], airports$long[1:2], 
#                       airports$lat[3:4], airports$long[3:4])

#TextOnStaticMap