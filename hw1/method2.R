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
    if(method == 3) library(FastCSVSample) # csvSample()
    
    time. = system.time({
      
      files = list.files(direc)
      
      tables = list(); length(tables) = length(files)
      
      for(i in 21:22) {#1:length(files)
        file.i = paste0(direc, '/', files[i])
        if(verbose) print(file.i)
        if(i <= 21) col.num = 15 else col.num = 45
        if(verbose) print(col.num)
        
        if(method == 2) {
          dat = read.csv(file.i, colClasses = 'character')
        }
        
        if(method == 3) {
          n = 100
          dat = csvSample(file.i, n)
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
    
    paste0('results', method) = 
      list(time = time., 
           results = c(mean = mu, median = med, sd = std), 
           quantiles = quantiles, 
           session = sessionInfo())
    save(paste0('results', method), 
         file = paste0('results', method, '.rda'))
  }

method2.fun()
