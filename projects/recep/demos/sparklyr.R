install.packages("sparklyr")
install.packages("dplyr") 
install.packages("devtools") 
install.packages("data.table", type = "source",
                 repos = "http://Rdatatable.github.io/data.table",dependencies = TRUE)
install.packages("ggplot2")
install.packages("aws.s3")
install.packages("DBI")

library(sparklyr)
library(dplyr)
library(data.table)
library(ggplot2)
library(devtools)
library(aws.s3)
library(DBI)

# https://www.ecloudture.com/en/emr-machine-learning-with-r-spark/

Sys.setenv(SPARK_HOME="/usr/lib/spark")
Sys.getenv("SPARK_HOME")

config <- list() 

sc <- spark_connect(master = "yarn-client", config = config, version = '2.4.0')

dbGetQuery(sc, "USE noshow")  
result <- DBI::dbGetQuery(sc, 'show databases')

dataset <- tbl(sc, sql("SELECT * FROM noshow.noshow_parquetfiles LIMIT 100"))

dbSendQuery(sc,"SELECT * FROM noshow.noshow_parquetfiles LIMIT 100")

tbl_change_db(sc,"xyz")

spark_disconnect(sc)


Sys.info()

