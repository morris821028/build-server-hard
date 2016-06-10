import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object SimpleApp {
  def main(args: Array[String]) {
    val logFile = "hdfs://debian02:9500/wordcount/test.medium" 
    val conf = new SparkConf()
				.setAppName("Simple Application")
				.setMaster("spark://debian02:7577")
//				.setMaster("local")
				.set("spark.executor.memory", "500mb")
				.set("spark.executor.cores", "2")
    val sc = new SparkContext(conf)
    val logData = sc.textFile(logFile)

//	var logData = List("a b a a b", "b")
	val counts = logData.flatMap(line => line.split(" "))
							.map(word => (word, 1))
							.reduceByKey(_ + _)
//	counts.collect().foreach(x => println(s"${x._1}\t${x._2}"))
	counts.map(x => x._1 + "\t" + x._2).saveAsTextFile("hdfs://debian02:9500/user/morris1028/output/")
	sc.stop()
  }
}
