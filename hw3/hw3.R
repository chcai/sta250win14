library('MASS')

dat = read.csv('train-sample.csv', header = TRUE, nrows = 10)
names(dat)

dat = read.csv('train-sample.csv', header = TRUE, 
               colClasses = c('NULL', 'character', 'NULL', 
                              'character', 'numeric', 'numeric', 
                              'character', 'character', 'NULL', 
                              'NULL', 'NULL', 'NULL', 
                              'NULL', 'NULL', 'character'))

y = character(length = nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 'open'
y[dat[,'OpenStatus'] != 'open'] = 'closed'

PostCreationDate = as.POSIXlt(dat[,'PostCreationDate'], 
                              format = '%m/%d/%Y %H:%M:%S')
OwnerCreationDate = as.POSIXlt(dat[,'OwnerCreationDate'], 
                               format = '%m/%d/%Y %H:%M:%S')
diff.time = 
  ceiling(
    as.numeric(
      difftime(PostCreationDate, OwnerCreationDate, 
               units = 'days')))

## word counts?

X = 
  data.frame(
    cbind(
      ReputationAtPostCreation = 
        dat[,'ReputationAtPostCreation'], 
      OwnerUndeletedAnswerCountAtPostTime = 
        dat[,'OwnerUndeletedAnswerCountAtPostTime'], 
      diff.time))

set.seed(1)
sub.set = sample.int(nrow(dat), nrow(dat)-10000)
fit = lda(formula = y ~ ., data = X, prior = c(.06, .94), 
          subset = sub.set)

sum(predict(fit, X[-sub.set,])$class == dat[-sub.set, 'OpenStatus'])

#dat.test = read.csv('test.csv', header = TRUE)
