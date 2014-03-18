library('SVGAnnotation')

plots = list.files('plots')

doc = xmlParse("airports.svg")
p = getPlotPoints(doc)

lapply(1:length(big.airports), function(i) 
  addToolTips(p[[169+i]], 
              paste0(airports$iata[i], ' (', 
                     airports$city[i], ', ', airports$state[i], 
                     ')'), 
              addArea = TRUE))
lapply(1:length(big.airports), function(i) 
  addLink(p[[169+i]], paste0('plots/', plots[i])))

saveXML(doc, 'airports.svg')
