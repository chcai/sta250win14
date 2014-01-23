# process results from the 3 methods

setwd("C:/Users/Christine/Google Drive/GitHub/sta250win14/hw1")
load('results1.rda')
results1
load('results2.rda')
results2
load('results3b.rda')
results4 = results3
load('results3.rda')
results3

means = c(results1$results[1], results2$results[1], 
          results3$results[1], results4$results[1])
med = c(results1$results[2], results2$results[2], 
        results3$results[2], results4$results[2])
sds = c(results1$results[3], results2$results[3], 
        results3$results[3], results4$results[3])
png('stats.png')
par(mfrow = c(2,2), mar = c(5+2,4,4,2))
plot(means, type = 'b', xaxt = 'n', xlab = '', ylab = '', 
     main = 'Mean', las = 2)
axis(1, at = 1:4, 
     labels = c('Shell', 'read.csv()', 
                'csvSample()', 'Fixed csvSample()'), 
     las = 2, cex.axis = .8)
plot(med, type = 'b', xaxt = 'n', xlab = '', ylab = '', 
     main = 'Median', las = 2)
axis(1, at = 1:4, 
     labels = c('Shell', 'read.csv()', 
                'csvSample()', 'Fixed csvSample()'), 
     las = 2, cex.axis = .8)
plot(sds, type = 'b', xaxt = 'n', xlab = '', ylab = '', 
     main = 'Sd', las = 2)
axis(1, at = 1:4, 
     labels = c('Shell', 'read.csv()', 
                'csvSample()', 'Fixed csvSample()'), 
     las = 2, cex.axis = .8)
dev.off()

for.plot = numeric(4)
for.plot[1] = results1$time[3]
for.plot[2] = results2$time[3]
for.plot[3] = results3$time[3]
for.plot[4] = results3$time[3]

for.plot.mins = for.plot/60

png('speed.png')
par(mfrow = c(1,2), mar = c(5+5,4,4,2))
barplot(for.plot, 
        names.arg = c('Shell', 'read.csv()', 
                      'csvSample()', 
                      'Fixed csvSample()'), 
        ylab = 'Seconds', 
        main = 'Speed', 
        las = 2)
mtext('Method', 1, line = 8)
barplot(for.plot.mins, 
        names.arg = c('Shell', 'read.csv()', 
                      'csvSample()', 
                      'Fixed csvSample()'), 
        ylab = 'Minutes', 
        main = 'Speed', 
        las = 2)
mtext('Method', 1, line = 8)
dev.off()
