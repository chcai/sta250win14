#!/usr/bin/env python

## import 'packages'
import sys

## initialize the current key and current count
current_key = None
current_count = 0

## input comes from stdin.
## this input is the sorted output from the mapper.
## loop over each line in the file
for line in sys.stdin:
    ## remove leading and trailing whitespaces
    line = line.strip()
    ## split the line into key and count
    key, count = line.split('\t')
    ## convert count to integer
    count = int(count)
    
    ## this if-switch only works because hadoop sorts the mapper output
    ## by key before it is passed to the reducer.
    ## if the new key is the same as the current key,
    ## increment the current count by 1, 
    ## or more generally, by count
    if current_key == key:
        current_count += count
    else:
        ## if the new key is different from the current key
        ## and the current key is NOT None, 
        ## i.e. this is not the first line of the file, 
        ## print result to stdout
        if current_key:
            print '%s,%s' % (current_key,current_count)
        ## if the new key is different from the current key
        ## reset the current count to 1, 
        ## or more generally, to count
        ## and set the current key to be the new key
        current_count = count
        current_key = key

## print the last result
print '%s,%s' % (current_key,current_count)
