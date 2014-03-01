body.fun = function(x, dat, y) 
{
  body.x = dat[y == x, 'BodyMarkdown']
  body.x = paste0(body.x, collapse = ' ')
  body.x = 
    strsplit(body.x, 
             split = '[[:blank:]]+|[[:punct:]]+|[[:space:]]+')
  body.x2 = 
    body.x[[1]][nchar(body.x[[1]]) > 3]
  body.x3 = sort(table(body.x2), decreasing = TRUE)
}

body.open = body.fun(1, dat, y)
body.closed = body.fun(0, dat, y)

words = 
  c(names(body.open)[1:100][!names(body.open)[1:100] %in% 
                              names(body.closed)[1:100]], 
    names(body.closed)[1:100][!names(body.closed)[1:100] %in% 
                                names(body.open)[1:100]])

save(words, file = 'words.rda')

load('words.rda')

body.logi = 
  sapply(words, function(word) grepl(word, dat[,'BodyMarkdown']))

save(body.logi, file = 'body_logi.rda')
