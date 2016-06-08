#!/bin/bash

hdfs dfs -rm -r -f avg-output
hadoop jar /usr/local/hadoop-2.7/share/hadoop/tools/lib/hadoop-streaming-2.7.2.jar \
-files mapper.py,reducer.py,combiner.py\
-mapper mapper.py \
-reducer reducer.py \
-combiner combiner.py \
-input avg-input/avg-input.large -output morris1028/avg-output \
-numReduceTasks 2 \

