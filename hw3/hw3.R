# library('MASS')
# library('car')

dat0 = read.csv('train-sample.csv', header = TRUE, nrow = 1)
names(dat0)

# dat = 
#   read.csv('train-sample.csv', header = TRUE, 
#            colClasses = c('NULL', 'character', 'factor', 
#                           'character', 'integer', 'integer', 
#                           'character', 'character', 'character', 
#                           'character', 'character', 'character', 
#                           'character', 'NULL', 'character'))
# save(dat, file = 'dat.rda')

load('dat.rda')

dat = dat[dat[,'ReputationAtPostCreation'] >= 1, ]

PostCreationDate = 
  as.POSIXlt(dat[,'PostCreationDate'], 
             format = '%m/%d/%Y %H:%M:%S')
OwnerCreationDate = 
  as.POSIXlt(dat[,'OwnerCreationDate'], 
             format = '%m/%d/%Y %H:%M:%S')
diff.time = 
  ceiling(
    as.numeric(
      difftime(PostCreationDate, OwnerCreationDate, 
               units = 'days')))
dat = dat[diff.time >= 1, ]
diff.time = diff.time[diff.time >= 1]

y = numeric(nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 1
y[dat[,'OpenStatus'] != 'open'] = 0

tag.logi = matrix(nrow = nrow(dat), ncol = 5)
for(j in 1:5) tag.logi[,j] = dat[, paste0('Tag', j)] != ''
tag.num = apply(tag.logi, 1, sum)

load('body_logi.rda')

X = 
  cbind(dat[, c('OwnerUserId', 'ReputationAtPostCreation', 
               'ReputationAtPostCreation')], 
        diff.time, tag.num, body.logi)
X[,1] = as.integer(X[,1])

set.seed(1)
sub.set = sample.int(nrow(dat), nrow(dat)-10000)
fit = glm(formula = as.factor(y) ~ ., data = X, 
          family = 'binomial', subset = sub.set)

pred = predict.glm(fit, X[-sub.set,], type = 'response')

y2 = numeric(length(pred))
y2[pred >= .5] = 1
y2[pred < .5] = 0

sum(y2 == y[-sub.set])

#dat.test = read.csv('test.csv', header = TRUE)
