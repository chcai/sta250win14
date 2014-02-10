Method 1 is in gauss folder; this method uses read.csv() on the cluster gauss.

computation time: 2.5 mins.

gauss.R reads a csv file (ignoring all cols but arrival delays through colClasses) and makes a frequency table.

gauss.sh is the shell script needed to execute gauss.R on gauss.

gaussPro.R computes the desired statistics from the array jobs outputs.

gaussPro.sh is the shell script needed to execute gaussPro.R on gauss.

commands.txt contains the commands to run this method.



Method 2 is in mapReduce folder; this method implements MapReduce with python.

computation time: 13.5 mins + 2 mins to copy files to hdfs.

mapper.py is the mapper.

reducer.py is the reducer.

mapRedPro.R computes the desired statistics from the MapReduce output.

commands.txt contains the commands to run this method.



Method 2.5 is in mapRedJava folder; this method implements MapReduce with Java.

computation time: 7 mins.

ArrivalDelayMapper.java is the mapper.

ArrivalDelayReduce.java is the reducer.

mapRedJavaPro.R computes the desired statistics from the MapReduce output.

commands.txt contains the commands to run this method.



results*.rda's contain the results and systems info for the corresponding methods.

report.doc/.pdf is the report.

plots.R makes plot(s) for the report (ignore).

times.png is in the report.