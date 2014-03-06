### process results and make plot(s)

this = scan('this.txt')
this2 = scan('this2.txt')
this3 = scan('this3.txt')
png('this.png')
plot(this/10000, type = 'b', pch = 1, 
     xlab = '', ylab = 'Correctly Classified (Percent)', 
     ylim = c(.6, .7))
points(this2/10000, type = 'b', pch = 2)
points(this3/10000, type = 'b', pch = 3)
legend('bottomright', 
       legend = c('Logistic', 'Probit', 'Trees'), 
       pch = 1:3)
dev.off()
