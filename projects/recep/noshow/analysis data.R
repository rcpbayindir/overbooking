
# SQL
sample_data <- DBI::dbGetQuery(sc, " SELECT * FROM noshow.parquetfiles LIMIT 100")

sample_data_dcs <- DBI::dbGetQuery(sc, " SELECT * FROM noshow.dcs_dcs LIMIT 100")


rawPnrData <- dplyr::tbl (sc, "parquetfiles") 

rawDcsData <- dplyr::tbl (sc, "dcs_dcs") 

sdf_dim(rawPnrData)
--[1] 348734100        41

sdf_dim(rawDcsData)
--[1] 30364     7



head(rawDcsData)
head(rawPnrData)

rawPnrData%>%
  filter(!is.na(noshow_count))


sample <- as.data.frame(rawData%>%
                          filter(pnr_no =='UWJNUH' & id_pnr_creation_ymd =='20171214' & date_ymd == 20171214 & his_seq == 13)) 


sample

SELECT *  FROM "noshow"."noshow_parquetfiles" where pnr_no ='UWJNUH' and trim(id_pnr_creation_ymd) = '20171214' and pnr_time = '1121' and date_ymd = '20171214' and his_seq = '13' and psgr_ref_no = '1'
order by date_ymd ,his_seq, psgr_ref_no;





sample$id_pnr_creation_ymd

lubridate::ymd(sample$id_pnr_creation_ymd)

lubridate::ymd_hms(sample$dep_date_num)



sample$pnr_no <- as.character(sample$pnr_no)
sample$id_pnr_creation_ymd <- lubridate::ymd(sample$id_pnr_creation_ymd)
sample$pnr_time  <- as.numeric(sample$pnr_time )
sample$date_ymd <- lubridate::ymd(sample$date_ymd)
sample$his_seq <- as.numeric(sample$his_seq)
sample$pnr_his_log_seq <- as.numeric(sample$pnr_his_log_seq)
sample$id_pnr_his_log_ymd <- lubridate::ymd(sample$id_pnr_his_log_ymd)
sample$pnr_his_log_time <- as.numeric(sample$pnr_his_log_time)
sample$logtime_gmt <- lubridate::dmy_hms(sample$logtime_gmt)
sample$last_log_entry_ymd <- lubridate::ymd(sample$last_log_entry_ymd)
sample$local_boarding_flag <- as.character(sample$local_boarding_flag)
sample$psgr_ref_no <- as.numeric(sample$psgr_ref_no)
sample$sgm_ref_no <- as.numeric(sample$sgm_ref_no)
sample$iti_carrier <- as.character(sample$iti_carrier)
sample$flight <- as.character(sample$flight)
sample$selling_class <- as.character(sample$selling_class)
sample$dep_date <- lubridate::ymd_hms(sample$dep_date)
sample$arr_date <- lubridate::ymd_hms(sample$arr_date)
sample$origin_point <- as.character(sample$origin_point)
sample$destination_point <- as.character(sample$destination_point)
sample$aac_cal <- as.character(sample$aac_cal)
sample$oac_cal <- as.character(sample$oac_cal)
sample$ond_seq <- as.numeric(sample$ond_seq)
sample$passenger_type <- as.character(sample$passenger_type)
sample$id_pnr_creater_agt_cntry <- as.numeric(sample$id_pnr_creater_agt_cntry)
sample$pos <- as.character(sample$pos)
sample$channel_type <- as.character(sample$channel_type)
sample$ticketed_status <- as.numeric(sample$ticketed_status)
sample$outbound_flag <- as.character(sample$outbound_flag)
sample$ssr_flag <- as.character(sample$ssr_flag)
sample$day_of_week <- as.numeric(sample$day_of_week)
sample$dep_time_range <- as.numeric(sample$dep_time_range)
sample$creation_day_to_departure <- as.numeric(sample$creation_day_to_departure)
sample$log_day_to_departure <- as.numeric(sample$log_day_to_departure)
sample$last_modified_date_to_derparture <- as.numeric(sample$last_modified_date_to_derparture)
sample$creation_dtd_range <- as.numeric(sample$creation_dtd_range)
sample$log_dtd_range <- as.numeric(sample$log_dtd_range)
sample$last_modified_dtd_range <- as.numeric(sample$last_modified_dtd_range)
sample$dep_date_num <- lubridate::ymd(sample$dep_date_num)
sample$ds_dcs_status <- as.character(sample$ds_dcs_status)
sample$noshow_count <- as.numeric(sample$noshow_count)


sdf_describe(sample)
