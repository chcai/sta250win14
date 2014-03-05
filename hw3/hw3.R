# library('MASS')
# library('car')

dat0 = read.csv('train-sample.csv', header = TRUE, nrow = 1)
names(dat0)

# dat = 
#   read.csv('train-sample.csv', header = TRUE, 
#            colClasses = c('NULL', 'character', 'NULL', 
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

# title.nwords = 
#   sapply(1:nrow(dat), function(i) 
#     length(gregexpr('\\w+', dat[i, 'Title'])[[1]]))
# 
# save(title.nwords, file = 'title_nwords.rda')

# body.nwords = 
#   sapply(1:nrow(dat), function(i) 
#     length(gregexpr('\\w+', dat[i, 'BodyMarkdown'])[[1]]))
# 
# save(body.nwords, file = 'body_nwords.rda')
load('body_nwords.rda')

tag.logi = matrix(nrow = nrow(dat), ncol = 5)
for(j in 1:5) tag.logi[,j] = dat[, paste0('Tag', j)] != ''
tag.num = apply(tag.logi, 1, sum)

load('body_logi.rda')

y = numeric(nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 1
y[dat[,'OpenStatus'] != 'open'] = 0

X = 
  cbind(dat[, c('ReputationAtPostCreation', 
                'OwnerUndeletedAnswerCountAtPostTime')], 
        diff.time, body.nwords, tag.num, body.logi)

set.seed(1)
sub.set = sample.int(nrow(dat), nrow(dat)-10000)
fit = glm(formula = as.factor(y) ~ ., data = X, 
          family = 'binomial', subset = sub.set)

pred = predict.glm(fit, X[-sub.set,], type = 'response')

y2 = numeric(length(pred))
y2[pred >= .5] = 1
y2[pred < .5] = 0

sum(y2 == y[-sub.set])
