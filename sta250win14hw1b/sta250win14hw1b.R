system.time({
  files = list.files('data')
  table. = list()
  length(table.) = length(files)
  
  for(i in 81) {
    file.i = paste0('data/', files[i])
    if(i <= 21) col.name = 'ArrDelay' else col.name = 'ARR_DELAY'
    
    dat = read.csv(file.i, colClasses = 'character')
    table.i = table(as.integer(dat[,col.name]))
    counts = as.numeric(table.i)
    arr.delay = as.integer(attributes(table.i)$dimnames[[1]])
    table.[[i]] = cbind(counts, arr.delay)
  }
})
