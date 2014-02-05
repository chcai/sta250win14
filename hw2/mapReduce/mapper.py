#!/usr/bin/env python

## import 'packages'
import sys

## input comes from stdin.
## loop over each line in the file
for line in sys.stdin:
    ## remove leading and trailing whitespaces
    line = line.strip()
    ## split the line by comma
    entries = line.split(',')
    
    ## if there are less than 44 elements in a line
    ## i.e. the pre-2008 files:
    if entries.__len__() < 44:
        ## ignore header and NA's
        if entries[14] != 'ArrDelay' and entries[14] != 'NA':
            ## make sure we're going to get nice, clean integers
            ## for arrival delays
            arr_delay = int(entries[14])
            ## print key, value pair to stdout.
            ## since we want a frequency table, 
            ## each key is an arrival delay
            ## and each value is 1
            print '%s\t%s' % (arr_delay, 1)
        else:
            ## if entry is header or NA, 
            ## print value 0 so it doesn't get counted in reducer
            print '%s\t%s' % (0, 0)
    ## if post-2008 files:
    ## very similar to above
    else:
        if entries[44] != '"ARR_DEL15"' and entries[44] != '':
            ## python cannot convert entries such as '-2.00' to integer.
            ## so split on '.' and grab the '-2'
            arr_delay = int(entries[44].split('.')[0])
            print '%s\t%s' % (arr_delay, 1)
        else:
            print '%s\t%s' % (0, 0)
            