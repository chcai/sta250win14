Method 1 is in gauss folder.

computation time: 2.5 mins.

gauss.R reads a csv file (ignoring all cols but arrival delays through colClasses) and makes a frequency table.

gauss.sh is the shell script needed to execute gauss.R on gauss.

gaussPro.R computes the desired statistics.

results1.rda contains the results and system info.



Method 2 is in mapReduce folder.

computation time: 13.5 mins + 2 mins to copy files to hdfs

mapRedPro.R computes the desired statistics from the MapReduce output



report.doc is a work in progress report.



### please ignore the following

scp results2.rda chcai@gumbel.ucdavis.edu:~