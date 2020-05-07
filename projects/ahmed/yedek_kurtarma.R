library(sparklyr)

rm(list = ls())

config <- spark_config()

config$spark.yarn.am.memory	 <- "20G"
config$spark.driver.memory	<- "20G"
config$spark.yarn.am.cores <- 64
config$spark.executor.instances <- 4
config$spark.dynamicAllocation.enabled <- "false"

sc_yarn <- spark_connect(master="yarn", app_name = "test_yarn", config=config, version = '2.4.0')


spark_session_config(sc_yarn)

spark_disconnect(sc_yarn)


dbNames <- DBI::dbGetQuery(sc_yarn, 'show databases')

DBI::dbGetQuery(sc_yarn, "Use noshow")

tableNames <- dplyr::db_list_tables(sc_yarn)

rawData <- tbl(sc_yarn, "20191227_parquetfiles")

head(rawData)


tempData <- rawData %>%
  mutate(id_pnr_creation_ymd = as.integer(id_pnr_creation_ymd),
         pnr_time = as.integer(pnr_time),
         date_ymd = as.integer(date_ymd),
         last_log_entry_ymd = as.integer(last_log_entry_ymd),
         # dep_date,
         # arr_date,
         creation_day_to_departure = as.integer(creation_day_to_departure),
         last_modified_date_to_departure = as.integer(last_modified_date_to_departure),
         noshow_count = as.integer(noshow_count))



sdf_describe(tempData)


tempData <- rawData %>%
  dplyr::group_by(pnr_no) %>%
  dplyr::summarise(n = n()) %>%
  dplyr::arrange(dplyr::desc(n))

pnrData <- rawData %>%
  dplyr::filter(pnr_no == "S3CCUF") %>%
  dplyr::collect()

pnrData <- pnrData %>%
  dplyr::group_by(psgr_ref_no) %>%
  unique() %>%
  ungroup()

