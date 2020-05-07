sample_data <- p_dbData%>%
  compute()%>%
  dplyr::sample_n(10)



src_tbls(sc)


raw_data <- spark_read_table(sc, "dbplyr_008")

xxxx <- raw_data%>%
  sample_n(20000)%>%
  collect()

head(xxxx)


sdf_dim(raw_data)


sdf_describe(raw_data)

sdf_describe((raw_data))

colNames_test <- colnames((raw_data))

tempData <- raw_data %>%
  dplyr::select(id_pnr_creater_agt_cntry)

pnrData <- raw_data %>%
  dplyr::filter(pnr_no == "TQK235") %>%
  dplyr::collect()

pnrData <- pnrData %>%
  dplyr::group_by(psgr_ref_no) %>%
  unique() %>%
  ungroup()

pnrDataSW68J8 <- raw_data %>%
  dplyr::filter(pnr_no == "SW68J8") %>%
  dplyr::collect()


dim(pnrDataSW68J8)
