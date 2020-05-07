

con <- DBI::dbConnect(RPostgreSQL::PostgreSQL(),
                      dbname = "noshow",
                      user    = rstudioapi::askForPassword("Database user"),
                      password    = rstudioapi::askForPassword("Database password"),
                      host = "thydatascience.cz5yzlgzs0u9.eu-west-1.rds.amazonaws.com",
                      port = 5432)


con

dbExistsTable(con, "noshow_parquetfiles")

query = "SELECT * FROM noshow_parquetfiles where pnr_no = 'TBREBU' limit 10" 


df_postgres <- dbGetQuery(con, query)


dbDisconnect(con)
dbUnloadDriver(drv)


