make.tables.fun = function(dat, col.num) {
  table.i = table(as.integer(dat[,col.num]))
  counts = as.numeric(table.i)
  arr.delay = as.integer(attributes(table.i)$dimnames[[1]])
  tables[[i]] = cbind(counts, arr.delay)
}