install.packages("aws.s3")
library("aws.s3")

Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIA3UETQOPTBSMZTSXQ","AWS_SECRET_ACCESS_KEY" = "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")


b <- 'tk-datascience-projects'
objects <- get_bucket(b)
noshow_dataset_201806<-get_object(object= "noshow_project/raw_data/pnr/noshow_dataset_201806.csv.gz",bucket= b)

spark_read_parquet(sc, name, path, options = list(), repartition = 0,
                   memory = TRUE, overwrite = TRUE, columns = NULL, schema = NULL,
                   ...)


spark_read_parquet(
  sc, name = "parquet01", path = "s3://tk-datascience-projects/noshow_project/parquetFiles/part-00000-1004c04b-8074-410b-aad9-d6844b8d9d48-c000.snappy.parquet",   memory = FALSE
)



result <- DBI::dbGetQuery(sc_test, 'show databases')
result

