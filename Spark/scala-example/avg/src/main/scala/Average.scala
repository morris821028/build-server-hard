import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object Average {
	def f(x: String) : (String, (Int, Int)) = {
		var parts = x.split("\\s+")
		return (parts(0), (parts(1).toInt, 1))
	}
	def g(x: (Int, Int), y: (Int, Int)) : ((Int, Int)) = {
		return ((x._1 + y._1, x._2 + y._2))
	}
	def h(x: (String, (Int, Int))) : (String, Double) = {
		var a = x._1
		var b = x._2
		return (a, b._1.toDouble / b._2)
	}
	def main(args: Array[String]) {
	    val logFile = "hdfs://debian02:9500/average/test.large"
		val conf = new SparkConf()
		.setAppName("Average")
		.setMaster("spark://debian02:7577")
//		.setMaster("local")
		.set("spark.executor.memory", "500mb")
		.set("spark.executor.cores", "2")
		val sc = new SparkContext(conf)
		val logData = sc.textFile(logFile)

		var counts = logData.map(line => f(line))
							.reduceByKey((x, y) => g(x, y))
							.map(x => h(x))
//		counts.collect().foreach(x => println(s"${x._1}\t${x._2}"))
		counts.map(x => x._1 + "\t" + x._2).saveAsTextFile("hdfs://debian02:9500/user/morris1028/output")
		sc.stop()
	}
}
