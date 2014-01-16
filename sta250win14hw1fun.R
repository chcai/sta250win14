table.fun = function(i, files, nrows. = 10) {
  file.i = paste0('data/', files[i])
  when = strsplit(files[i], '.', fixed=TRUE)
  when = when[[1]][1]
  tmp = read.csv(file.i, nrows=nrows.+1)
  col.num = which(names(tmp) == 'ArrDelay')
  if(length(col.num) == 0) {
    col.num = which(names(tmp) == 'ARR_DELAY')
    arr.delay = tmp[,col.num]
    tmp = readLines(file.i, nrows.+1)
    tmp = sapply(2:(nrows.+1), function(j) strsplit(tmp[j], ','))
    col.num = lapply(1:nrows., function(j) {
      which(as.integer(tmp[[j]]) == arr.delay[j])
    })
    tmp = which(sapply(1:nrows., function(j) {
      length(col.num[[j]]) == 1
    }))
    col.num = col.num[[tmp[1]]]
  }
  system(paste0('cat ', file.i, ' | cut -f ', col.num, 
                ' -d , | sort | uniq -c > tables/table', when, 
                '.txt'), 
         intern=TRUE)
}
