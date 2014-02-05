Method 1 is in gauss folder.

computation time: 2.5 mins.

gauss.R reads a csv file (ignoring all cols but arrival delays through colClasses) and makes a frequency table.

gauss.sh is the shell script needed to execute gauss.R on gauss.

gaussPro.R computes the desired statistics.

results1.rda contains the results and system info.

report.doc is a work in progress report.


### please ignore the following for now

cat data/2008_May.csv | python mapper.py | sort -k1,1 | python reducer.py > ctable.txt

wget http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2
tar jxf Delays1987_2013.tar.bz2 -C data &

scp output/part* chcai@gumbel.ucdavis.edu:~

hadoop fs -copyFromLocal data/* data

ls $HADOOP_HOME

hadoop fs -copyToLocal output ./

find $HADOOP_HOME  -name '*streaming*.jar'
locate streaming | grep jar

thank the heavens for this simple, clean data structure.

the data has to be much bigger for hadoop to outperform gauss. possibly if the data is so big we can't even get it onto gauss.

hadoop: 6.5 mins for mapper to finish, reducer started before mapper finished, total 13.5 mins