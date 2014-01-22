# R CMD INSTALL -l "Rlib" FastCSVSample
# export R_LIBS="Rlib"
# .libPaths()

method2.3.fun = 
  function(method, 
           direc = 'data', 
           verbose = TRUE)
  {
    
    if(method != 2 && method != 3) {
      stop('Invalid method.')
    }
    
    library(Hmisc) # wtd.mean(), wtd.var(), wtd.quantile()
    if(method == 3) {
      library(FastCSVSample) # csvSample()
      source('sampleSize.R')
    }
    
    time. = system.time({
      
      files = list.files(direc)
      
      if(method == 3) {
        sample.sizes = sample.size.fun(100000*81, direc)
      }
      
      tables = list(); length(tables) = length(files)
      
      for(i in 1:length(files)) {
        
        file.i = paste0(direc, '/', files[i])
        if(i <= 21) col.num = 15 else col.num = 45
        if(verbose) {
          print(paste0('Processing file: ', file.i, 
                       ', column number = ', col.num))
        }
        
        if(method == 2) {
          dat = read.csv(file.i, colClasses = 'character')
        }
        
        if(method == 3) {
          dat = csvSample(file.i, sample.sizes[i])
          dat = strsplit(dat, ',')
          dat = t(as.data.frame(dat))
        }
        
        table.i = table(as.integer(dat[,col.num]))
        counts = as.numeric(table.i)
        arr.delay = as.integer(attributes(table.i)$dimnames[[1]])
        tables[[i]] = cbind(counts, arr.delay)
      }
      
      save(tables, file = paste0('tables', method, '.rda'))
      
      table. = do.call(rbind, tables)
      
      counts = by(table.[,1], table.[,2], sum, simplify = FALSE)
      counts = as.numeric(counts)
      arr.delay = sort(unique(table.[,2]))
      
      mu = wtd.mean(arr.delay, counts)
      std = sqrt(wtd.var(arr.delay, counts))
      quantiles = wtd.quantile(arr.delay, counts)
      med = quantiles[3]
    })
    
    assign(paste0('results', method), 
           list(time = time., 
                results = c(mean = mu, median = med, sd = std), 
                quantiles = quantiles, 
                session = sessionInfo()))
    save(list = paste0('results', method), 
         file = paste0('results', method, '.rda'))
  }

method2.3.fun(3)
