#!/bin/bash

hdfs dfs -rm -r output
spark-submit \
  --class "Average" \
  ./target/scala-2.10/average_2.10-1.0.jar

