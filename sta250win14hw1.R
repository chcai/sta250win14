i=2
files = list.files('data')
file.i = paste0('data/', files[i])
tmp = read.csv(file.i)
mean(tmp$ArrDelay, na.rm=TRUE)
# 9.446699, 6.54735, , 6.809947
sd(tmp$ArrDelay, na.rm=TRUE)
# 25.82553, 23.32517
median(tmp$ArrDelay, na.rm=TRUE)
# 4

# shell:
wget http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2
tar jxf Delays1987_2013.tar.bz2 -C data

for f in table*
do
echo $f
cat $f | tail -n +2 | head -n -1 >> ctable.txt
done

cat tables/ctable1.txt tables2/ctable2.txt > ctable.txt
