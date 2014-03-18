library('SVGAnnotation')

## load the data saved in maps.R
load('dat2.rda')

plots = list.files('plots')

## parse the svg file 
## and get the plot points
doc = xmlParse("airports.svg")
p = getPlotPoints(doc)

## for each airport, 
## add tooltip: airport code (city, state), 
## and link to each airport to the plots created in plots.R. 
## tooltips will display when mousing over the airports
lapply(1:length(big.airports), function(i) 
  addToolTips(p[[169+i]], 
              paste0(airports$iata[i], ' (', 
                     airports$city[i], ', ', airports$state[i], 
                     ')'), 
              addArea = TRUE))
lapply(1:length(big.airports), function(i) 
  addLink(p[[169+i]], paste0('plots/', plots[i])))

saveXML(doc, 'airports.svg')
