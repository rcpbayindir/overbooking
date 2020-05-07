install.packages("RMySQL")
install.packages("DBI")
install.packages("RODBC")
install.packages("RODBCDBI")
install.packages("dplyr")
install.packages("tidyquant",dependencies = TRUE)
devtools::install_github("r-dbi/odbc")

library(RODBCDBI)
library(RMySQL)
library(DBI)
library(dplyr)
library(tidyquant)

cn <- dbConnect(drv      = RMySQL::MySQL(), 
                user     = "thy_arch",
                password = "ThyArch2019",
                host     = "thydatasciencemysql.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com",
                port     = 3306,
                dbname   = "thydatasciencemysql"")


