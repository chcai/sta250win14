library('MASS')
library('car')

dat = read.csv('train-sample.csv', header = TRUE, 
               colClasses = c('NULL', 'character', 'numeric', 
                              'character', 'numeric', 'numeric', 
                              'character', 'character', 'character', 
                              'character', 'character', 'character', 
                              'character', 'NULL', 'character'))
names(dat)

y = numeric(nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 1
y[dat[,'OpenStatus'] != 'open'] = 0

PostCreationDate = as.POSIXlt(dat[,'PostCreationDate'], 
                              format = '%m/%d/%Y %H:%M:%S')
OwnerCreationDate = as.POSIXlt(dat[,'OwnerCreationDate'], 
                               format = '%m/%d/%Y %H:%M:%S')
diff.time = 
  ceiling(
    as.numeric(
      difftime(PostCreationDate, OwnerCreationDate, 
               units = 'days')))

tag.log = matrix(nrow = nrow(dat), ncol = 5)
for(j in 1:5) {
  tag.log[,j] = dat[, paste0('Tag', j)] != ''
}
tag.num = apply(tag.log, 1, sum)

## word counts?

X = 
  data.frame(
    cbind(
      as.numeric(diff.time), 
      as.factor(dat[,'OwnerUserId']), 
      as.numeric(dat[,'ReputationAtPostCreation']), 
      as.numeric(dat[,'OwnerUndeletedAnswerCountAtPostTime']), 
      as.numeric(tag.num)))

set.seed(1)
sub.set = sample.int(nrow(dat), nrow(dat)-10000)
fit = glm(formula = as.factor(y) ~ ., data = X, 
          family = 'binomial', subset = sub.set)

tmp = predict.glm(fit, X[-sub.set,], type = 'response')

y2 = numeric(length(tmp))
y2[tmp >= .5] = 1
y2[tmp < .5] = 0

sum(y2 == y[-sub.set])

#dat.test = read.csv('test.csv', header = TRUE)
