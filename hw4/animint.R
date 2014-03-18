library('animint')
library('maps')

## load the data saved in maps.R
load('dat2.rda')

## get the mean departure delays by origin airport and carrier. 
## put delays into matrix form for ease
dep.dels = 
  by(dat$DepDelay, list(dat$Origin, dat$UniqueCarrier), 
     mean, na.rm = TRUE)
dep.dels = matrix(dep.dels, nrow = length(big.airports))

## get carriers in alphabetical order
carriers = sort(as.character(unique(dat$UniqueCarrier)))

## misnomer; should be called my.labels. 
## the airports on the map will be color coded 
## by mean departure delays. 
## these will serve as labels for the colors.
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

## data frame to be used for plotting
to.plot = 
  as.data.frame(
    matrix(c(rep(airports$long, length(carriers)), 
             rep(airports$lat, length(carriers))), 
           ncol = 2))
to.plot = cbind(to.plot, as.vector(my.colors), 
                rep(1:length(carriers), each = length(big.airports)))
names(to.plot) = c('long', 'lat', 'Delays', 'carriers')

## for plotting US map
USpolygons = map_data('state')
USpolygons$state = 
  state.abb[match(USpolygons$region, tolower(state.name))]

map <- ggplot() + 
  geom_polygon(aes(x = long, y = lat, group = group), 
               data = USpolygons, fill = "white", colour = "grey") + 
  geom_point(aes(x = long, y = lat, showSelected = carriers, 
                 colour = Delays), 
             data = to.plot, size = 4) + 
  scale_color_manual(
    values = 
      c('NA' = 'grey', '< 10 mins' = 'green', 
        '10 - 20 mins' = 'yellow', '> 20 mins' = 'red'))

## every five seconds, changes carrier; 
## so carrier is the 'time' variable
all.dels = 
  by(dat$DepDelay, dat$UniqueCarrier, mean, na.rm = TRUE)
to.plot.ts = 
  as.data.frame(cbind(1:length(carriers), all.dels))
names(to.plot.ts) = c('carriers', 'Delays')

ts <- ggplot() + 
  make_tallrect(to.plot.ts, 'carriers') + 
  geom_line(aes(carriers, Delays),
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
