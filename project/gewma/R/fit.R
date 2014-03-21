fit.gewma = 
  function(X, M = 20, 
           r = seq(0, 1, length.out = 2+5), 
           alpha = seq(0, pi, length.out = 2+5)) 
  {
    n = length(X)
    
    theta = -1 + 1:(2*M)/M
    theta.exp = sapply(1:n, function(j) theta^(j-1))
    
    r = r[-c(1, length(r))]
    alpha = alpha[-c(1, length(alpha))]
    
    r.exp = sapply(1:(n-1), function(j) r^j)
    sine = sapply(1:(n-1), function(j) sin((j+1)*alpha))
    
    Z = list(); length(Z) = 3
    
    Z[[1]] = sapply(1:length(theta), function(i) 
    {
      if(theta[i] == 1)
      {
        tmp = sapply(1:(n-1), function(t.) rep(1/t., t.)%*%X[t.:1])
        return(tmp)
      } else
      {
        tmp = sapply(1:(n-1), function(t.)
          theta.exp[i, 1:t.]%*%X[t.:1]/(1 - theta[i]^t.))
        return((1 - theta[i])*tmp)
      }
    })
    
    Z[[2]] = sapply(1:length(theta), function(i) 
    {
      if(theta[i] == 0 || theta[i] == 1) return(rep(0, n-1))
      tmp = sapply(1:(n-1), function(t.) 
      {
        w = theta[i]/(1-theta[i])^2 + theta[i]/(1-theta[i])
        (2:(t.+1)*theta.exp[i, 2:(t.+1)])%*%X[t.:1]/w
      })
      return(tmp)
    })
    
    Z[[3]] = lapply(1:length(r), function(rr) 
      sapply(1:length(alpha), function(a) 
      {
        w = r.exp[rr,]*sine[a,]
        tmp = sapply(1:(n-1), function(t.) w[1:t.]%*%X[t.:1])
        return(tmp/sin(alpha[a]))
      }))
    
    Z[[3]] = do.call(cbind, Z[[3]])
    
    Z = do.call(cbind, Z)
    
    fit.lm = lm(X[2:n] ~ 0)
    for.mula = sapply(1:ncol(Z), function(j) sprintf('Z[,%d]', j))
    for.mula = paste0(for.mula, collapse = '+')
    for.mula = paste0('~', for.mula)
    fit = step(fit.lm, scope = as.formula(for.mula), 
               direction = 'forward', trace = 0, k = log(n))
    
    this = list('fit' = fit, 
                'X' = X, 
                'M' = M, 
                'r' = r, 
                'alpha' = alpha)
    class(this) = 'gewma'
    
    return(this)
  }
