library(DBI)

#===================================#
#===== connect to yarn cluster =====#
#===================================#



#----- connect to the yarn cluster with the default configuration -----#

 Sys.setenv(HADOOP_CONF_DIR = '/etc/hadoop/conf')
 Sys.setenv(YARN_CONF_DIR = '/etc/hadoop/conf')

# sc <- spark_connect(master = "yarn-cluster", version = "2.4.0")


conf <- spark_config()

conf$spark.driver.maxResultSize <- "4G"
conf$spark.driver.cores <- 8
conf$spark.driver.memory <- "20G"
conf$spark.executor.cores <- 16
conf$spark.executor.memory <- "20G"
conf$spark.executor.instances <- 16
conf$`sparklyr.shell.driver-memory` <- "32G"
conf$spark.sql.catalogImplementation <- "hive"


#----- her adımda spark log'ları consola sparklyr.log.console TRUE ise basılıyor.

#conf$sparklyr.log.console <- TRUE 
#conf$sparklyr.verbose <- TRUE 

sc <- spark_connect(master = "yarn",
                    app_name = "athena_demo",
                    version = "2.4.0",
                    config = conf)


spark_config()

result <- DBI::dbGetQuery(sc, 'show databases')
result

src_databases(sc)


dbGetQuery(sc, "USE NOSHOW")  
result <- DBI::dbGetQuery(sc, " SELECT * FROM default.noshow_pnr LIMIT 100")



tbl(sc, "noshow_pnr") # dplyr
dbGetQuery(con, "SELECT * FROM mytable") # SQL

getNoshowSample <- DBI::dbGetQuery(sc, "SELECT * FROM 'default'.'noshow_pnr' LIMIT 100")


dbGetQuery(sc, "USE default")  

t <- tbl(sc, "noshow_pnr")


dsub = tbl(sc, sql(query))
finData<-spark_read_csv(sc=sc
                        ,path ='hdfs://ip-10-0-1-134.eu-west-1.compute.internal:8020/user/thyarch/noshow/*.csv.gz'
                        ,infer_schema = TRUE
                        ,header = TRUE
)



dplyr::db_drop_table(sc,"customers")

sdf_dim(myData)*41


rm(noshow_dataset_201806)
