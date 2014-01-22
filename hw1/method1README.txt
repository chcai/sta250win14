I downloaded the files and extracted them on gumbel as follows:

wget http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2
tar jxf Delays1987_2013.tar.bz2 -C data

The file method1fun.R contains a function which takes in a list of files, 
a number specifying which file in this list, 
and makes a freq table for arrival delay  for that file.

It also contains another function which loops through all the csv files that we were given.

Running method1run.R with the appropriate input and output directories will result in 
a list (of txt files) of freq tables, one for each csv file.
These tables have name format tableYear.txt or tableYear_month.txt, 
depending on whether they are from before or after 2008.

I manually put the tables for 2008 and after into a separate directory, tables2.
This allows me to run the following in shell:

### cd to tables dir
for f in table*
do
echo $f
cat $f | tail -n +2 | head -n -1 >> ctable.txt
done

### cd to tables2 dir
for f in table*
do
echo $f
cat $f | head -n -2 >> ctable.txt
done

The former is for 2008 and after, the latter is for pre-2008.
Note that these are done in the appropriate directories.
This will result in two concatenated tables with only the integer arrival delay times 
we care about; i.e. entries like

1 "ArrDelay"

are not included.
Concatenate these two ctable.txt's into one ctable.txt with:

### cd to dir containing tables and tables2 dir
cat tables/ctable.txt tables2/ctable.txt > ctable.txt

Running method1pro.R will read the final ctable.txt, 
merge entries across files to get a final freq table, 
and calculate the desired statistics with the wtd.stats() functions in the Hmisc package.