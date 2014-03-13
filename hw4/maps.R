library('maps')

svg('airports2.svg')
map('state', bg = 'white')
points(airports$long, airports$lat, col = 'blue', pch = 16)
dev.off()