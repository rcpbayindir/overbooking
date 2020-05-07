library(DBI)



result <- DBI::dbGetQuery(sc, 'show databases')
result


dbGetQuery(sc, "USE default") 

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



sdf_dim()