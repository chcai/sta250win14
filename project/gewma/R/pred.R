predict.gewma = 
  function(object, n.pred = 10, ...) 
  {
    fit = object
    X = fit$X
    M = fit$M
    r = fit$r
    alpha = fit$alpha
    fit = fit$fit
    
    n = length(X)
    N = n + n.pred
    
    theta = -1 + 1:(2*M)/M
    theta.exp = sapply(1:N, function(j) theta^(j-1))
    
    r.exp = sapply(1:(N-1), function(j) r^j)
    sine = sapply(1:(N-1), function(j) sin((j+1)*alpha))
    
    for(t. in n:(N-1)) 
    {
      c. = sapply(1:length(fit$coef), function(j) 
      {
        tmp = strsplit(names(fit$coef)[j], ' ')[[1]][2]
        i = as.integer(strsplit(tmp, ']')[[1]][1])
        if(i <= 2*M) {
          if(theta[i] == 1)
          {
            tmp = rep(1/t., t.)%*%X[t.:1]
            return(tmp)
          } else
          {
            tmp = theta.exp[i, 1:t.]%*%X[t.:1]/(1 - theta[i]^t.)
            return((1 - theta[i])*tmp)
          }
        } else if(i > 2*M && i <= 4*M)
        {
          i = i - 2*M
          w = theta[i]/(1-theta[i])^2 + theta[i]/(1-theta[i])
          tmp = (2:(t.+1)*theta.exp[i, 2:(t.+1)])%*%X[t.:1]/w
          return(tmp)
        } else 
        {
          i = i - 4*M
          rr = ceiling(i/length(r))
          a = i%%length(alpha)
          if(a == 0) a = length(alpha)
          w = r.exp[rr,]*sine[a,]
          tmp = w[1:t.]%*%X[t.:1]
          return(tmp/sin(alpha[a]))
        }
      })
      X = c(X, c.%*%fit$coef)
    }
    
    return(X[(n+1):N])
  }
