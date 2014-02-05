#!/usr/bin/env python

# import 'packages'
import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # split the line by comma
    entries = line.split(',')
    
    if entries.__len__() < 44:
        if entries[14] != 'ArrDelay' and entries[14] != 'NA':
            arr_delay = int(entries[14])
            print '%s\t%s' % (arr_delay, 1)
        else:
            print '%s\t%s' % (0, 0)
    else:
        if entries[44] != '"ARR_DEL15"' and entries[44] != '':
            arr_delay = int(entries[44].split('.')[0])
            print '%s\t%s' % (arr_delay, 1)
        else:
            print '%s\t%s' % (0, 0)
            