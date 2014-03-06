### creates variables data frame

# initial look at variables
dat0 = read.csv('train-sample.csv', header = TRUE, nrow = 1)
names(dat0)

dat = 
  read.csv('train-sample.csv', header = TRUE, 
           colClasses = c('NULL', 'character', 'NULL', 
                          'character', 'integer', 'integer', 
                          'character', 'character', 'character', 
                          'character', 'character', 'character', 
                          'character', 'NULL', 'character'))
# save dat so we don't have to re-read
save(dat, file = 'dat.rda')
load('dat.rda')

# lowest rep should be 1
dat = dat[dat[,'ReputationAtPostCreation'] >= 1, ]

# get number of days between owner creation 
# and post creation
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
# remove entries where post is created before account
dat = dat[diff.time >= 1, ]
diff.time = diff.time[diff.time >= 1]

# get number of words in the title.
# ignore, not a good predictor
# title.nwords = 
#   sapply(1:nrow(dat), function(i) 
#     length(gregexpr('\\w+', dat[i, 'Title'])[[1]]))
# save(title.nwords, file = 'title_nwords.rda')

# get number of words in the body
body.nwords = 
  sapply(1:nrow(dat), function(i) 
    length(gregexpr('\\w+', dat[i, 'BodyMarkdown'])[[1]]))
save(body.nwords, file = 'body_nwords.rda')
load('body_nwords.rda')

# get number of tags.
# ignore, not a good predictor
# tag.logi = matrix(nrow = nrow(dat), ncol = 5)
# for(j in 1:5) tag.logi[,j] = dat[, paste0('Tag', j)] != ''
# tag.num = apply(tag.logi, 1, sum)

# see body.R
load('body_logi.rda')

# create binary response vector
y = numeric(nrow(dat))
y[dat[,'OpenStatus'] == 'open'] = 1
y[dat[,'OpenStatus'] != 'open'] = 0

# put all predictors into a data frame
X = 
  cbind(dat[, c('ReputationAtPostCreation', 
                'OwnerUndeletedAnswerCountAtPostTime')], 
        diff.time, body.nwords, body.logi)
save(X, y, file = 'X.rda')