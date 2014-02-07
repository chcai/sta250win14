/*
 Take each line of each CSV file and output the ArrDelay value and the constant 1
 to represent an observation for that particular delay value.
 We ignore the header and NA values.
 */

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;

import org.apache.hadoop.mapreduce.Mapper;

public class ArrivalDelayMapper extends Mapper<LongWritable, Text, IntWritable, IntWritable> {

    public void map(LongWritable key, Text value, Context context) 
      	            throws IOException, InterruptedException 
    {
	int delay;
	/* split line by comma's */
	String[] els = value.toString().split(",");

	/* if there are less than 44 elements in a line, i.e. the pre-2008 files: */
	if(els.length < 44) {
		/* ## ignore header and NA's */
		if(!els[14].equals("ArrDelay") && !els[14].equals("NA")) {
			delay = Integer.parseInt(els[14]);
			/* return <key, value> pair. since we want a frequency table, 
            		   each key is an arrival delay and each value is 1 */
			context.write(new IntWritable(delay), new IntWritable(1));
		}
	}
	/* if post-2008 files: (very similar to above) */
	if(els.length > 44) {
		if(!els[44].equals("\"ARR_DEL15\"") && !els[44].equals("")) {
			/* java cannot convert entries such as '-2.00' to integer.
            		   so split on '.' and grab the '-2' */
			String[] delays = els[44].toString().split("\\.");
			delay = Integer.parseInt(delays[0]);
			context.write(new IntWritable(delay), new IntWritable(1));
		}
	}
    }

}