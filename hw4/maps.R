library('maps')

load('dat2.rda')

svg('airports2.svg')
map('state', bg = 'white', col = 8)
points(airports$long, airports$lat, col = 'blue', pch = 16)
sapply(1:nrow(airports2), function(i) 
  lines(c(airports$long[airports$iata == 'SFO'], 
          airports2$long[i]), 
        c(airports$lat[airports$iata == 'SFO'], 
          airports2$lat[i]), 
       col = cols[i]))
# sapply(1:29, function(i) 
#   sapply((i+1):30, function(j) 
#     lines(c(airports$long[i], airports$long[j]), 
#           c(airports$lat[i], airports$lat[j]))))
dev.off()