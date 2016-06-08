#!/bin/bash

for i in worker1 worker2 worker3 worker4;
do
	set -x #echo on
	scp -r /usr/local/hadoop-2.7/etc/hadoop/* hadoop@${i}:/usr/local/hadoop-2.7/etc/hadoop
	set +x
done;

#scp /usr/local/hadoop-2.7/etc/hadoop/yarn-site.xml hadoop@worker1:/usr/local/hadoop-2.7/etc/hadoop/yarn-site.xml

#scp /usr/local/hadoop-2.7/etc/hadoop/core-site.xml hadoop@worker1:/usr/local/hadoop-2.7/etc/hadoop/core-site.xml

#scp /usr/local/hadoop-2.7/etc/hadoop/hdfs-site.xml hadoop@worker1:/usr/local/hadoop-2.7/etc/hadoop/hdfs-site.xml

