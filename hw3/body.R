### processes body

body.fun = function(x, dat, y) 
{
  # get body for open OR closed posts
  body.x = dat[y == x, 'BodyMarkdown']
  # combine into one string
  body.x = paste0(body.x, collapse = ' ')
  # split on spaces and punctuations
  body.x = 
    strsplit(body.x, 
             split = '[[:blank:]]+|[[:punct:]]+|[[:space:]]+')
  # grab the words that have more than 3 letters
  body.x2 = 
    body.x[[1]][nchar(body.x[[1]]) > 3]
  # table these words and sort so most frequent word comes first
  body.x3 = sort(table(body.x2), decreasing = TRUE)
}

# call above function for open and closed posts
body.open = body.fun(1, dat, y)
body.closed = body.fun(0, dat, y)

# get most frequent words. 
# but remove words that appear in both open and closed posts
n = 500
words = 
  c(names(body.open)[1:n][!names(body.open)[1:n] %in% 
                              names(body.closed)[1:n]], 
    names(body.closed)[1:n][!names(body.closed)[1:n] %in% 
                                names(body.open)[1:n]])
save(words, file = 'words.rda')
load('words.rda')

# for each word in words, 
# does body i contain this word?
body.logi = 
  sapply(words, function(word) grepl(word, dat[,'BodyMarkdown']))
save(body.logi, file = 'body_logi.rda')
