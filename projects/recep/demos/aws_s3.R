

library("aws.s3")

Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIA3UETQOPTBSMZTSXQ","AWS_SECRET_ACCESS_KEY" = "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")


#https://sciwiki.fredhutch.org/compdemos/aws-R/ 
  
b <- 'tk-datascience-projects'
objects <- get_bucket(b)

df <- s3read_using(read.csv, object="noshow_project/raw_data/dcs/DCS_DATA.csv", bucket=b)
get_object(object= "noshow_project/raw_data/pnr/noshow_dataset_201806.csv.gz",bucket= b)

df_201806 <- s3read_using(read.csv, object="noshow_project/raw_data/pnr/noshow_dataset_201806.csv.gz ", bucket=b)


head(df)

noshow_dataset_201806.csv.gz <- get_object(object= "noshow_project/raw_data/pnr/noshow_dataset_201806.csv.gz",bucket= b)

noshow_dataset_201806.csv <- memDecompress(noshow_dataset_201806.csv.gz, "gzip", asChar = TRUE)
 
read.csv(text = rawToChar(get_object("noshow_project/raw_data/pnr/noshow_dataset_201806.csv.gz", "tk-datascience-projects")))
