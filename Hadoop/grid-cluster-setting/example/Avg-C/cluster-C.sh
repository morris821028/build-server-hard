#!/bin/bash

hdfs dfs -rm -r -f avg-output
hadoop jar /usr/local/hadoop-2.7/share/hadoop/tools/lib/hadoop-streaming-2.7.2.jar \
-files mapper,reducer,combiner \
-mapper mapper \
-reducer reducer \
-combiner combiner \
-input /user/hadoop/avg-input/avg-input.large -output avg-output \
-numReduceTasks 2 \
-partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner

