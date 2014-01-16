I downloaded the files and extracted them on gumbel as follows:

wget http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2
tar jxf Delays1987_2013.tar.bz2 -C data

The file sta250win14hw1fun.R contains a function which takes in a list of files, a number specifying which file in this list, and makes a freq table for arrival delay  for that file.

sta250win14hw1run.R loops through all the files we are given and runs the function in sta250win14hw1fun.R. This will result in a list of freq tables, one for each file. These tables have name format tableYear.txt or tableYear_month.txt, depending on whether they are from before or after 2008.

I manually put the tables for 1987-2007 into one directory, and the others into a separate directory. This allows me to run the following in shell:

for f in table*
do
echo $f
cat $f | tail -n +2 | head -n -1 >> ctable.txt
done

for f in table*
do
echo $f
cat $f | head -n -2 >> ctable.txt
done

The former is for 2008 and after, the latter is for pre-2008. Note that these are done in different directories. This will result in two concatenated tables with only the integer arrival delay times we care about; i.e. entries like

1 "ArrDelay"

are not included. Concatenate these two ctable.txt's into one ctable.txt.

cat tables/ctable.txt tables2/ctable.txt > ctable.txt

sta250win14hw1pro.R reads the final ctable.txt, merges entries across files to get a final freq table, and calculates the desired statistics with the wtd.stats() functions in the Hmisc package.