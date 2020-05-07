if (nchar(Sys.getenv("SPARK_HOME")) < 1) {
  Sys.setenv(SPARK_HOME = "/usr/lib/spark")
}
library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))
sparkR.session(master = "yarn", sparkConfig = list(spark.driver.memory = "2g"))

sparkR.session(enableHiveSupport = TRUE)


sql("CREATE DATABASE IF NOT EXISTS NOSHOWDB")

result <- sql("SHOW DATABASES")
result <- sql("SHOW TABLES")

sql("CREATE TABLE IF NOT EXISTS NOSHOWDB.noshow(
  pnr_no string,
    id_pnr_creation_ymd string,
    pnr_time string,
    date_ymd string,
    his_seq string,
    pnr_his_log_seq string,
    id_pnr_his_log_ymd string,
    pnr_his_log_time string,
    logtime_gmt string,
    last_log_entry_ymd string,
    local_boarding_flag string,
    psgr_ref_no string,
    sgm_ref_no string,
    iti_carrier string,
    flight string,
    selling_class string,
    dep_date string,
    arr_date string,
    origin_point string,
    destination_point string,
    aac_cal string,
    oac_cal string,
    ond_seq string,
    passenger_type string,
    id_pnr_creater_agt_cntry string,
    pos string,
    channel_type string,
    ticketed_status string,
    outbound_flag string,
    ssr_flag string,
    day_of_week string,
    dep_time_range string,
    creation_day_to_departure string,
    log_day_to_departure string,
    last_modified_date_to_derparture string,
    creation_dtd_range string,
    log_dtd_range string,
    last_modified_dtd_range string,
    dep_date_num string,
    ds_dcs_status string,
    noshow_count string)")


sql("LOAD DATA LOCAL INPATH '/user/thyarch/noshow/*.csv.gz' INTO TABLE  NOSHOWDB.noshow")

# Queries can be expressed in HiveQL.
results <- sql("FROM noshow_pnr SELECT pnr_no")

# results is now a SparkDataFrame
head(results)