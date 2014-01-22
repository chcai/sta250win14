### this file contains two functions

### given a list of files and file i in this list, 
### make a freq table for arrival delay

table.fun = 
  function(i, # file number
           files, # files to process
           direc, # folder containing csv files
           dir.out, # (existing) folder to store output freq tables
           nrows.) # num of rows to compare
                   # in determining arrival delays col
  {
    file.i = paste0(direc, '/', files[i])
    # get year or year_month
    when = strsplit(files[i], '.', fixed=TRUE)
    when = when[[1]][1]
    # get col num of arrival delay to feed into shell later
    tmp = read.csv(file.i, nrows=nrows.+1)
    col.num = which(names(tmp) == 'ArrDelay')
    # files named year_month have different format.
    # get first nrows. entries of arrival delays from read.csv()
    # and compare to first nrows. from readLines()
    # and strsplit() by comma
    # i.e. how we will cut in shell later
    # to verify correct col num for arrival delay.
    # if an arrival delay from read.csv()
    # is only equal to an entry in one of the cols
    # from readLines()
    # then that should be the correct arrival delays col
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
    # use shell to get freq table and save to file
    system(paste0('cat ', file.i, ' | cut -f ', col.num, 
                  ' -d , | sort | uniq -c > ', dir.out, '/table', when, 
                  '.txt'), 
           intern = TRUE)
  }


### makes all freq tables (of arrival delay)
### and writes each table to txt file

method1.fun = 
  function(direc = 'data', # folder containing csv files
           dir.out = 'tables', # (existing) folder to store output 
                               # freq tables
           nrows. = 10) # num of rows to compare
    # in determining arrival delays col
  {
    time. = system.time({
      # loop through each file, make a freq table, 
      # and write to a txt file
      files = list.files(direc)
      lapply(1:length(files), function(i) {
        table.fun(i, files, direc, dir.out, nrows.)
      })
    })
    
    save(time., file='time.rda')
  }
