library(dplyr)
library(sparklyr)

sc

Noshow01<-spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201401.csv",name = "Noshow01",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201406.csv",name = "Noshow02",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201501.csv",name = "Noshow03",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201506.csv",name = "Noshow04",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201601.csv",name = "Noshow05",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201606.csv",name = "Noshow06",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201701.csv",name = "Noshow07",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201706.csv",name = "Noshow08",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201801.csv",name = "Noshow09",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201802.csv",name = "Noshow10",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201803.csv",name = "Noshow11",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201804.csv",name = "Noshow12",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201805.csv",name = "Noshow13",infer_schema = TRUE,header =TRUE,delimiter = ";")
spark_read_csv(sc = sc ,path = "/user/thyrstudio/noshow_data/noshow_dataset_201806.csv",name = "Noshow14",infer_schema = TRUE,header =TRUE,delimiter = ";")

src_tbls(sc) 

str(noshow01)

ns_tbl <- tbl(sc,"noshow01")

dim(ns_tbl)

object_size(ns_tbl)

print(ns_tbl, n = 5, width = Inf)

nrow(ns_tbl)

str(ns_tbl)
 


sparklyr::sdf_sample(noshow01)



 



noshow_table <- tbl(sc,"noshow01")%>%
  dplyr::mutate(PNR_NO = as.character(PNR_NO),
         NOSHOW_COUNT = as.numeric(NOSHOW_COUNT))%>%
  dplyr::filter(PNR_NO = "TIGH4W")

sdf_register(noshow_table, "noshow_spark")


sdf_sample(sc)

sdf_bind_rows()



import_iris <- copy_to(sc,, "spark_iris",
                       overwrite = TRUE) 