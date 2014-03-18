load('dat2.rda')

dat = dat[dat$Origin == 'SFO', ]
tmp = by(dat$Dest, dat$Dest, length)
airports2 = airports[!is.na(tmp), ]
tmp = tmp[!is.na(tmp)]

cols = rep(5, nrow(airports2))
cols[tmp < 4000] = 4
cols[tmp < 3000] = 3
cols[tmp < 2000] = 2
cols[tmp < 1000] = 1


# big.airports = sort(big.airports)
# boo = dat$Origin == big.airports[1] & dat$Dest == big.airports[4]
# boo2 = dat$Origin == big.airports[4] & dat$Dest == big.airports[1]
# sum(boo | boo2)
# 
# tmp = by(dat, list(dat$Origin, dat$Dest), nrow)
# tmp[is.na(tmp)] = 0
# tmp = matrix(tmp, nrow = 30)
# row.names(tmp) = big.airports
# colnames(tmp) = big.airports
# 
# volumn = 
#   sapply(1:29, function(i) 
#     sapply((i+1):30, function(j) tmp[i, j] + tmp[j, i]))
# volumn = unlist(volumn)