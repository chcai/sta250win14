library('animint')
library('maps')

load('dat2.rda')

airports = cbind(airports, 'time' = 1:30)

USpolygons <- map_data("state")
USpolygons$state = 
  state.abb[match(USpolygons$region, tolower(state.name))]

map <- ggplot() + 
  geom_polygon(aes(x = long, y = lat, group = group), 
               data = USpolygons, fill = "white", colour = "grey") + 
  geom_point(aes(x = long, y = lat, showSelected = time), 
             data = airports, colour = 'blue')
map

ts <- ggplot() +
  geom_point(aes(x = long, y = lat), 
             data = airports, colour = 'blue')

time <- list(variable = 'time', ms = 2000)

tornado.anim <- list(map = map, ts = ts, time = time, 
                     width = list(map = 970, ts = 400), 
                     height = list(400))

gg2animint(tornado.anim, "tornado-anim")




UStornadoCounts <-
  ddply(UStornadoes, .(state, year), summarize, count=length(state))

map <- ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group),
               data=USpolygons, fill="black", colour="grey") +
  geom_segment(aes(x=startLong, y=startLat, xend=endLong, yend=endLat,
                   showSelected=year),
               colour="#55B1F7", data=UStornadoes)

ts <- ggplot()+
  geom_line(aes(year, count),
            data=UStornadoCounts, alpha=3/5, size=4)

time <- list(variable="year", ms=2000) # new part of the list passed to gg2animint().

tornado.anim <- list(map=map, ts = ts, time=time, width=list(map = 970, ts = 400),  height=list(400)) # pass the time object in as another object in the main list. 

gg2animint(tornado.anim, "tornado-anim")
