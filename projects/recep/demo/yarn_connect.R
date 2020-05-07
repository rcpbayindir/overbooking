library(sparklyr)

spark_disconnect(sc_yarn)

config <- spark_config()
config$spark.num.executors <- 12
config$spark.executor.instances <- 3
config$spark.executor.cores <- 15
config$spark.yarn.am.cores <- 16
#config$spark.driver.memory <- "10G"
config$spark.executor.memory <- "20G"
config$spark.yarn.executor.memoryOverhead = "4G"
#config$spark.dynamicAllocation.enabled <- "false"

sc_yarn <- spark_connect(master="yarn", app_name = "test_yarn", config=config, version = '2.4.0')

sc_yarn2 <- spark_connect(master="yarn", app_name = "test_yarn2", version = '2.4.0')

sc_yarn3 <- spark_connect(master="yarn", app_name = "test_yarn3", version = '2.4.0')


spark_disconnect(sc_yarn)

spark_connection_is_open(sc_test)

spark_session(sc_yarn)

sc <- spark_connect(master = "yarn", app_name = "test", spark_home="/usr/lib/spark", config = list(
  `sparklyr.shell.driver-memory`="10G",
  spark.sql.shuffle.partitions="5000",
  spark.driver.maxResultSize="5000",
  spark.dynamicAllocation.enabled="true"
))
 