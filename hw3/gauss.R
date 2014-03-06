### given response vector and variables data frame, 
# set up to fit different models on different subsets 
# of the data on the gauss cluster. 
# writes number of correct predictions (for one model) 
# to a txt file

library('rpart') # rpart()

# get job number
args = as.numeric(commandArgs(TRUE))

# load response and variables data frame
load('X.rda')

# set a different seed for each job 
# and leave 10,000 observations out 
# when fitting the model.
# so we can predict these later 
# and compare to actually open or closed
set.seed(args)
sub.set = sample.int(nrow(X), nrow(X)-10000)

# if probability of being open is >= .5, 
# classify as open; else closed. 
# compare predictions to correct answer

# fit = glm(formula = as.factor(y) ~ ., data = X, 
#           family = 'binomial'(link = 'probit'), subset = sub.set)
# pred = predict.glm(fit, X[-sub.set,], type = 'response')
# y2 = numeric(length(pred))
# y2[pred >= .5] = 1
# y2[pred < .5] = 0
# this = sum(y2 == y[-sub.set])

fit = rpart(formula = as.factor(y) ~ ., data = X, 
          subset = sub.set, method = 'class')
pred = predict(fit, X[-sub.set,], type = 'class')
this = sum(pred == y[-sub.set])

write(this, file = paste0('output3/this_', 1000+args, '.txt'))
