
install.packages('devtools')
install.packages("sparklyr")
devtools::install_github('apache/spark@v2.4.0', subdir='R/pkg')
devtools::install_github("rstudio/sparklyr")
 
library(SparkR)
library(sparklyr)
library(dplyr)
library(nycflights13)


Sys.setenv(SPARK_HOME='/usr/lib/spark')
Sys.setenv(JAVA_HOME='/etc/alternatives/jre')
config$`sparklyr.shell.files` = "/etc/hive/conf/hive-site.xml"
hive_context_config(sc)




sc <- spark_connect(master = "yarn-client")
sc <- spark_connect(master = "yarn-client", version = "2.4.0")


spark_disconnect_all()

config <- spark_config()

result <- DBI::dbGetQuery(sc, 'show databases')
result

DBI::dbGetQuery(sc, 'select * from noshow.noshow_parquetfiles limit 100 ')

scR <- sparkR.session()

df <- createDataFrame(flights)

head(select(df, df$air_time, df$distance)) 

