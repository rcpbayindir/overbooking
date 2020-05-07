config <- spark_config()
config$spark.driver.cores <- 32
config$spark.executor.cores <- 32
config$spark.executor.memory <- "40g"

library(sparklyr)

Sys.setenv(SPARK_HOME = "/usr/lib/spark")
Sys.setenv(HADOOP_CONF_DIR = '/etc/hadoop/conf')
Sys.setenv(YARN_CONF_DIR = '/etc/hadoop/conf')

config <- spark_config()
config$spark.executor.instances <- 4
config$spark.executor.cores <- 8
config$spark.executor.memory <- "8G"

sc_test <- spark_connect(master="yarn-cluster", config=config, version = '2.4.0')

sc_test
