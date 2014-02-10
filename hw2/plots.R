setwd("C:/Users/Christine/Google Drive/GitHub/sta250win14/hw1")

load('results2.rda')

hw1 = results2$time[3]

setwd("C:/Users/Christine/Google Drive/GitHub/sta250win14/hw2")

load('results1.rda')
load('results2.rda')
load('results3.rda')

png('times.png')
barplot(c(hw1, results1$time, results2$time, results3$time)/60, 
        names.arg = c(paste0('read.csv()\nnon-parallel'), 
                      paste0('read.csv()\non gauss'), 
                      paste0('MapReduce\nPython'), 
                      paste0('MapReduce\nJava')), 
        ylab = 'Time (Minutes)', 
        main = 'Computation Times')
dev.off()
