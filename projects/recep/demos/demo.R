Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIA3UETQOPTBSMZTSXQ","AWS_SECRET_ACCESS_KEY" = "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")



# hadoop configurations
ctx <- spark_context(sc)
jsc <- invoke_static( sc,
                      "org.apache.spark.api.java.JavaSparkContext",
                      "fromSparkContext",
                      ctx
)

hconf <- jsc %>% invoke("hadoopConfiguration")  
hconf %>% invoke("set", "com.amazonaws.services.s3a.enableV4", "true")
hconf %>% invoke("set", "fs.s3a.fast.upload", "true")

#https://s3-eu-west-1.amazonaws.com/tk-datascience-projects/noshow_project/raw_data/dcs/DCS_DATA.csv

folder_files<-"s3-eu-west-1.amazonaws.com/tk-datascience-projects/noshow_project/raw_data/dcs/"

rd_11<-spark_read_csv(sc,name = "DCS_DATA",path=folder_files, infer_schema = TRUE,header = T,delimiter = ";")


spark_disconnect(sc)