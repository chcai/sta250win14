library('animint')
library('maps')

load('dat2.rda')

# dat = dat[{dat$Month == 12 & dat$Origin == 'SFO'}, ]
# dep.dels = 
#   by(dat$DepDelay, list(dat$DayofMonth, dat$Dest), 
#      mean, na.rm = TRUE)

dep.dels = 
  by(dat$DepDelay, list(dat$Origin, dat$UniqueCarrier), 
     mean, na.rm = TRUE)
dep.dels = matrix(dep.dels, nrow = 30)

big.airports = sort(big.airports)
carriers = sort(as.character(unique(dat$UniqueCarrier)))
carriers[8] = 'PA'

my.colors = matrix(nrow = 30, ncol = 13)
for(j in 1:13)
  for(i in 1:30) 
  {
    if(is.na(dep.dels[i, j])) 
    {
      my.colors[i, j] = 'NA'
    } else 
    {
      if(dep.dels[i, j] <= 10) my.colors[i, j] = '< 10 mins'
      if(dep.dels[i, j] > 10 && dep.dels[i, j] <= 20) 
        my.colors[i, j] = '10 - 20 mins'
      if(dep.dels[i, j] > 20) my.colors[i, j] = '> 20 mins'
    }
  }

to.plot = 
  as.data.frame(
    matrix(
      c(rep(airports$long, 13), rep(airports$lat, 13)), ncol = 2))
to.plot = cbind(to.plot, as.vector(my.colors), rep(1:13, each = 30))
names(to.plot) = c('long', 'lat', 'colors', 'carrier')

USpolygons <- map_data("state")
USpolygons$state = 
  state.abb[match(USpolygons$region, tolower(state.name))]

map <- ggplot() + 
  geom_polygon(aes(x = long, y = lat, group = group), 
               data = USpolygons, fill = "white", colour = "grey") + 
  geom_point(aes(x = long, y = lat, showSelected = carrier, 
                 colour = colors), 
             data = to.plot, size = 4) + 
  scale_color_manual(
    values = 
      c('NA' = 'grey', '< 10 mins' = 'green', 
        '10 - 20 mins' = 'yellow', '> 20 mins' = 'red'))

all.dels = 
  by(dat$DepDelay, dat$UniqueCarrier, mean, na.rm = TRUE)
to.plot.ts = 
  as.data.frame(cbind(1:13, all.dels))
names(to.plot.ts) = c('carrier', 'delays')

ts <- ggplot() + 
  make_tallrect(to.plot.ts, 'carrier') + 
  geom_line(aes(carrier, delays),
            data = to.plot.ts) + 
  xlab('Carrier') + 
  ylab('Mean Departure Delay') + 
  scale_x_discrete(breaks = 1:13, 
                   labels = carriers)

time <- list(variable = 'carrier', ms = 5000)

air.anim <- list(map = map, ts = ts, time = time, 
                 width = list(map = 970, ts = 400), 
                 height = list(400))

gg2animint(air.anim, "tornado-anim")
