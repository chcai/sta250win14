### gives how many observations to sample from each file
### this is necessary because we want to sample all of 
### arrival delay uniformly (i.e. across all files)

sample.size.fun = 
  function(n, # roughly how many total samples you want
              # one way to choose:
              # if the files are the same size,
              # how many samples do you want from each file?
              # multiply that number by the number of files
              # to get n
           direc # directory containing the files to be sampled)
  {
    # change dir to direc, but track the orig working dir
    orig.dir = getwd()
    setwd(direc)
    files = list.files()
    # file.info() returns a data frame of info
    # extract size vector (numeric)
    file.sizes = file.info(files)$size
    # get the combined size of all the files
    total = sum(file.sizes)
    # get proportion of each file size to total
    sample.sizes = file.sizes/total
    # multiply the proportion by the number of total samples
    # to get the number of samples for each file
    # take ceiling (or floor) to get an integer
    sample.sizes = ceiling(sample.sizes*n)
    # reset to orig working dir
    setwd(orig.dir)
    sample.sizes
  }
