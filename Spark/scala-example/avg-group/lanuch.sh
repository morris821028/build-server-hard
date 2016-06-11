#!/bin/bash

hdfs dfs -rm -r output
spark-submit \
  --class "Average" \
  ./target/scala-2.10/average_2.10-1.0.jar
#  --master spark://debian02:7577 \
#  --executor-memory 20G \
#  --total-executor-cores 1 \

