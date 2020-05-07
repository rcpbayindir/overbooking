config <- spark_config()

config$`sparklyr.shell.driver-class-path` <- 
  "~/Downloads/mysql-connector-java-5.1.41/mysql-connector-java-5.1.41-bin.jar"

sc <- spark_connect(master = "local",
                    version = "2.1.0",
                    config = config)

spark_read_jdbc(sc2, "person_jdbc",  options = list(url = "jdbc:postgresql://thydatascience.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com:3306/sparklyr",user = "thyarch",password = "ThyArch2019",dbtable = "noshow"))
