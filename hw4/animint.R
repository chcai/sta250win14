library('animint')
library('maps')

load('dat2.rda')

dep.dels = 
  by(dat$DepDelay, list(dat$Origin, dat$UniqueCarrier), 
     mean, na.rm = TRUE)
dep.dels = matrix(dep.dels, nrow = length(big.airports))

carriers = sort(as.character(unique(dat$UniqueCarrier)))

my.colors = matrix(nrow = length(big.airports), 
                   ncol = length(carriers))
for(j in 1:length(carriers))
  for(i in 1:length(big.airports)) 
  {
    if(is.na(dep.dels[i, j])) 
      my.colors[i, j] = 'NA' else 
    {
      if(dep.dels[i, j] <= 10) my.colors[i, j] = '< 10 mins'
      if(dep.dels[i, j] > 10 && dep.dels[i, j] <= 20) 
        my.colors[i, j] = '10 - 20 mins'
      if(dep.dels[i, j] > 20) my.colors[i, j] = '> 20 mins'
    }
  }

to.plot = 
  as.data.frame(
    matrix(c(rep(airports$long, length(carriers)), 
             rep(airports$lat, length(carriers))), 
           ncol = 2))
to.plot = cbind(to.plot, as.vector(my.colors), 
                rep(1:length(carriers), each = length(big.airports)))
names(to.plot) = c('long', 'lat', 'my.colors', 'carriers')

USpolygons = map_data('state')
USpolygons$state = 
  state.abb[match(USpolygons$region, tolower(state.name))]

map <- ggplot() + 
  geom_polygon(aes(x = long, y = lat, group = group), 
               data = USpolygons, fill = "white", colour = "grey") + 
  geom_point(aes(x = long, y = lat, showSelected = carriers, 
                 colour = my.colors), 
             data = to.plot, size = 4) + 
  scale_color_manual(
    values = 
      c('NA' = 'grey', '< 10 mins' = 'green', 
        '10 - 20 mins' = 'yellow', '> 20 mins' = 'red'))

all.dels = 
  by(dat$DepDelay, dat$UniqueCarrier, mean, na.rm = TRUE)
to.plot.ts = 
  as.data.frame(cbind(1:length(carriers), all.dels))
names(to.plot.ts) = c('carriers', 'delays')

ts <- ggplot() + 
  make_tallrect(to.plot.ts, 'carriers') + 
  geom_line(aes(carriers, delays),
            data = to.plot.ts) + 
  xlab('Carrier') + 
  ylab('Mean Departure Delay (Mins)') + 
  scale_x_discrete(breaks = 1:length(carriers), 
                   labels = carriers) + 
  ggtitle('Overall Departure Delays by Carrier')

time <- list(variable = 'carriers', ms = 5000)

air.anim <- list(map = map, ts = ts, time = time, 
                 width = list(map = 970, ts = 400), 
                 height = list(400))

gg2animint(air.anim, "airports-anim")
