library(data.table)
library(bit64) 
library(R.utils)

colClassNames <-c( "character",
                   "integer",
                   "character",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "character",
                   "character",
                   "character",
                   "character",
                   "character",
                   "character",
                   "character",
                   "integer",
                   "character",
                   "integer",
                   "integer",
                   "character",
                   "character",
                   "character",
                   "character",
                   "integer",
                   "character",
                   "integer",
                   "character",
                   "integer",
                   "character",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer",
                   "integer"
                   )




url <- "/home/thyarch/projects/s3_files/raw_data_20191226.csv.gz" 

system.time(data <- fread(url ,colClasses = colClassNames)) 


saveRDS(data,file="data.RData")

