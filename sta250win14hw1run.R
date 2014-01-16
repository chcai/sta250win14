source('sta250win14hw1fun.R')

time. = system.time({
  files = list.files('data')
  lapply(1:length(files), function(i) table.fun(i, files))
})

save(time., file='time.rda')
