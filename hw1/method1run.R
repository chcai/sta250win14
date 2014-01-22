### makes all freq tables (of arrival delay)
### and writes each table to txt file

# function to make freq tables
source('sta250win14hw1fun.R')

time. = system.time({
  # loop through each file, make a freq table, 
  # and write to a txt file
  files = list.files('data')
  lapply(1:length(files), function(i) table.fun(i, files))
})

save(time., file='time.rda')
