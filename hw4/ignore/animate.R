library('SVGAnnotation')

# load('dat.rda')
# 
# flights = paste0(dat$UniqueCarrier, ' ', dat$FlightNum)
# 
# top.flights = sort(table(flights), decreasing = TRUE)
# top.flights = attributes(top.flights)$dimnames[[1]][1:30]
# 
# dat = dat[flights %in% top.flights, -c(1,11,14,20:21,23,25:29)]
# save(dat, top.flights, file = 'dat3.rda')
load('dat3.rda')
load('dat2.rda')

doc = xmlParse("airports2.svg")
p = getPlotPoints(doc)

tmp = rbind(cbind(airports$long, airports$lat)[1:2,], 
            cbind(airports$long+10, airports$lat+10)[1:2,])
tmp2 = rep(1:2, each = 2)
animate('airports2.svg', tmp, tmp2, 
        points = list(p[[170]], p[[171]]))

doc = svgPlot(plot(1:10))
data. = rbind(cbind(1:10, 1:10), 
            cbind(1:10, 1:10+.5))
which. = rep(1:2, each = 10)
animate(doc, data., which.)
