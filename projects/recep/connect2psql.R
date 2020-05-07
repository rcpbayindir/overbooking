
install.packages("RPostgreSQL")

install.packages('RPostgreSQL', dependencies=TRUE, repos='http://cran.rstudio.com/')

install.packages("odbc")

library(dplyr)
library(getPass)
library(RPostgreSQL)
library(odbc)
# install on linux libpq-dev package apt-get

rds <- src_postgres(dbname = 'noshow',
                    host = 'thydatascience.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com',
                    port = 5432,
                    user = 'thyarch',
                    password = getPass("Enter Password:"))

query = "SELECT DISTINCT pnr_no FROM noshow_parquetfiles limit 100" 

query = "SELECT *
FROM info_schema.columns
WHERE  table_name   = 'noshow_parquetfiles'"



db_connect <- function(){
  DBI::dbConnect(odbc::odbc(),
                 Driver       = "PostgreSQL",
                 servername   = "thydatascience.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com",
                 database     = "noshow",
                 UID          = "thyarch",
                 PWD          =getPass("Enter Password:") ,
                 Port         = 5432)
}
db_connect()


