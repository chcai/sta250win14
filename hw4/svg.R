library('SVGAnnotation')

load('dat2.rda')
plots = list.files('plots')

doc = xmlParse("airports2.svg")
p = getPlotPoints(doc)

lapply(1:30, function(i) 
  addToolTips(p[[169+i]], 
              paste0(airports$iata[i], ' (', 
                     airports$city[i], ', ', airports$state[i], 
                     ')'), 
              addArea = TRUE))
lapply(1:30, function(i) 
  addLink(p[[169+i]], paste0('plots/', plots[i])))

saveXML(doc, 'airports3.svg')

# op <- par(bg = "thistle")
# svg("/tmp/raster.svg")
# plot(c(100, 250), c(300, 450), type = "n", xlab = "", ylab = "")
# image <- as.raster(matrix(0:1, ncol = 5, nrow = 3))
# rasterImage(image, 100, 300, 150, 350, interpolate = FALSE)
# rasterImage(image, 100, 400, 150, 450)
# rasterImage(image, 200, 300, 200 + xinch(.5), 300 + yinch(.3), interpolate = FALSE)
# rasterImage(image, 200, 400, 250, 450, angle = 15, interpolate = FALSE)
# dev.off()
