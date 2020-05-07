install.packages("RMySQL")
library(RMySQL)

mydb <- dbConnect(MySQL(), user='thyarch', password='ThyArch2019',dbname = 'thydatascience_mysql',
                  host='thydatasciencemysql.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com')

dbListTables(mydb)
