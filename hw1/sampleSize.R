sample.size.fun = 
  function(n, direc)
  {
    orig.dir = getwd()
    setwd(direc)
    files = list.files()
    file.sizes = file.info(files)$size
    total = sum(file.sizes)
    sample.sizes = file.sizes/total
    sample.sizes = ceiling(sample.sizes*n)
    setwd(orig.dir)
    sample.sizes
  }
