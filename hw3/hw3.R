library('MASS')
library('car')

dat = read.csv('train-sample.csv', header = TRUE, nrow = 1)
names(dat)

dat = 
  read.csv('train-sample.csv', header = TRUE, 
           colClasses = c('NULL', 'character', 'numeric', 
                          'character', 'numeric', 'numeric', 
                          'character', 'character', 'character', 
                          'character', 'character', 'character', 
                          'character', 'NULL', 'character'))

y = numeric(nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 1
y[dat[,'OpenStatus'] != 'open'] = 0

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

# body.open = dat[y == 1, 'BodyMarkdown']
# body.open2 = paste0(body.open, collapse = ' ')
# body.open3 = 
#   strsplit(body.open2, 
#            split = '[[:blank:]]+|[[:punct:]]+|[[:space:]]+')
# body.open4 = body.open3[[1]][body.open3[[1]] != '']
# body.open5 = sort(table(body.open4), decreasing = TRUE)

tag.logi = matrix(nrow = nrow(dat), ncol = 5)
for(j in 1:5) tag.logi[,j] = dat[, paste0('Tag', j)] != ''
tag.num = apply(tag.logi, 1, sum)

X = 
  data.frame(
    cbind(as.numeric(diff.time), 
          as.factor(dat[,'OwnerUserId']), 
          as.numeric(dat[,'ReputationAtPostCreation']), 
          as.numeric(dat[,'OwnerUndeletedAnswerCountAtPostTime']), 
          as.numeric(tag.num)))

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
