var logFile = "hdfs://debian02:9500/wordcount/test.small"
val logData = sc.textFile(logFile)

logData.partitions.size

logData.mapPartitionsWithIndex(
(index: Int, it: Iterator[String]) =>
it.toList.map(x => if (index == 0) {println(x)}).iterator
).collect()

logData.mapPartitionsWithIndex(
(index: Int, it: Iterator[String]) =>
it.toList.map(x => if (index == 1) {println(x)}).iterator
).collect()

