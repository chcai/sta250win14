### method 2 reads entire csv files, makes freq tables, 
### and calculates the statistics

### method 3 uses FastCSVSample package to sample from each csv file, 
### makes freq tables, and calculates the statistics

# if no root permission, install FastCSVSample to own library
# R CMD INSTALL -l "Rlib" FastCSVSample
# export R_LIBS="Rlib"
# can check lib paths in R with .libPaths()

method2.3.fun = 
  function(method, # 2 or 3
           direc, # directory containing files to be processed
           verbose) # set to TRUE to print progress
  {
    
    # stop if method is not 2 or 3
    if(method != 2 && method != 3) {
      stop('Invalid method.')
    }
    
    library(Hmisc) # wtd.mean(), wtd.var(), wtd.quantile()
    if(method == 3) {
      library(FastCSVSample) # csvSample()
      # gives how many observations to sample from each file
      # this is necessary because we want to sample all of 
      # arrival delay uniformly (i.e. across all files)
      source('sampleSize.R')
    }
    
    time. = system.time({
      
      files = list.files(direc)
      
      if(method == 3) {
        # determine how many to sample from each file
        # dependent upon rough how many total samples you want
        # if the files are the same size
        # this would sample 10,000 observations from each file
        sample.sizes = sample.size.fun(10000*length(files), direc)
      }
      
      # allocate
      tables = list(); length(tables) = length(files)
      
      for(i in 1:length(files)) {
        
        # for convenience
        file.i = paste0(direc, '/', files[i])
        # arrival delay is col 15 for pre-2008 files
        # col 45 for 2008 and later.
        if(i <= 21) col.num = 15 else col.num = 45
        # if verbose = TRUE, print progress
        if(verbose) {
          print(paste0('Processing file: ', file.i, 
                       ', column number = ', col.num))
        }
        
        # read entire csv file
        if(method == 2) {
          dat = read.csv(file.i, colClasses = 'character')
        }
        
        # sample using FastCSVSample package
        if(method == 3) {
          dat = csvSample(file.i, sample.sizes[i])
          # setup to extract arrival delays col
          dat = strsplit(dat, ',')
          dat = t(as.data.frame(dat))
        }
        
        # makes freq table
        table.i = table(as.integer(dat[,col.num]))
        # turn this table into a matrix for computations later
        counts = as.numeric(table.i)
        # arrival delays are stored as names in the freq table
        arr.delay = as.integer(attributes(table.i)$dimnames[[1]])
        tables[[i]] = cbind(counts, arr.delay)
      }
      
      # save the list tables just in case (optional)
      save(tables, file = paste0('tables', method, '.rda'))
      
      # given a list of tables, concatenate them with rbind()
      table. = do.call(rbind, tables)
      
      # while ctable.txt is concatenated, 
      # it is not merged across files
      # i.e. there may be (and probably will be) >1 rows of counts
      # for arrival delay 0, etc.
      # use by() to merge counts for same arrival times
      counts = by(table.[,1], table.[,2], sum, simplify = FALSE)
      counts = as.numeric(counts)
      # by() sorts the arrival delays
      arr.delay = sort(unique(table.[,2]))
      
      # get the statistics
      mu = wtd.mean(arr.delay, counts)
      std = sqrt(wtd.var(arr.delay, counts))
      quantiles = wtd.quantile(arr.delay, counts)
      med = quantiles[3]
    })
    
    # save the results
    assign(paste0('results', method), 
           list(time = time., 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                session = sessionInfo()))
    save(list = paste0('results', method), 
         file = paste0('results', method, '.rda'))
  }

# function call
method2.3.fun(method = 3, direc = 'data', verbose = TRUE)
