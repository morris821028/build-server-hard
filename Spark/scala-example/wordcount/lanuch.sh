#!/bin/bash

hdfs dfs -rm -r output
spark-submit \
  --class "SimpleApp" \
  ./target/scala-2.10/simple-project_2.10-1.0.jar
#  --master spark://debian02:7577 \
#  --executor-memory 20G \
#  --total-executor-cores 1 \

