import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object Average {
	def f(x: String) : (String, Int) = {
		var parts = x.split("\\s+")
		return (parts(0), (parts(1).toInt))
	}
	def h(x: (String, Iterable[Int])) : (String, Double) = {
		var a = x._1
		var b = x._2
		var (tot, cnt) = (0, 0)
		for (num <- b) {
			tot += num
			cnt += 1	
		}
		return (a, tot.toDouble / cnt)
	}
	def main(args: Array[String]) {
	    val logFile = "hdfs://debian02:9500/average/test.large"
		val conf = new SparkConf()
		.setAppName("Average Group")
		.setMaster("spark://debian02:7577")
//		.setMaster("local")
		.set("spark.executor.memory", "500mb")
		.set("spark.executor.cores", "2")
		val sc = new SparkContext(conf)
		val logData = sc.textFile(logFile)

		var counts = logData.map(line => f(line))
							.groupByKey(22)
							.map(x => h(x))
//		counts.collect().foreach(x => println(s"${x._1}\t${x._2}"))
		counts.map(x => x._1 + "\t" + x._2).saveAsTextFile("hdfs://debian02:9500/user/morris1028/output")
		sc.stop()
	}
}
