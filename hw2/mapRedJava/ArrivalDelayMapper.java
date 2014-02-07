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
	String[] els = value.toString().split(",");
	if(els.length < 44) {
		if(!els[14].equals("ArrDelay") && !els[14].equals("NA")) {
			delay = Integer.parseInt(els[14]);
			context.write(new IntWritable(delay), new IntWritable(1));
		}
	}
	if(els.length > 44) {
		if(!els[44].equals("\"ARR_DEL15\"") && !els[44].equals("")) {
			String[] delays = els[44].toString().split("\\.");
			String[] delays2 = delays[1].toString().split("\\.");
			delay = Integer.parseInt(delays[0]);
			delay = Integer.parseInt(els[44]);
			context.write(new IntWritable(delay), new IntWritable(1));
		}
	}
    }

}