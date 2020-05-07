
library(parallel)
library(doParallel)

# Calculate the number of cores
no_cores <- detectCores() - 10

# Initiate cluster ,type = "FORK"
cl <- makeCluster(no_cores, outfile="/home/thyarch/projects/recep/output.txt")

registerDoParallel(cl)

clusterEvalQ(cl,  {
  library(caret)
  library(dplyr)
})

clusterExport(cl, "r_tFeatureVars")

clusterExport(cl, "r_tTargetVar")

clusterExport(cl, "xgbTrainControl")

clusterExport(cl, "xgbParamGrid")

trainFunc <- function(i){
    xgbCVObj <- caret::train(x = r_tFeatureVars,
                           y = r_tTargetVar,
                           method = "xgbTree",
                           metric = "RMSE",
                           trControl = xgbTrainControl,
                           tuneGrid = xgbParamGrid[i,])
}

system.time({
save_model <- parLapply(cl, 1:10, trainFunc)
})


system.time({
  save_model <- clusterApply(cl, 1:no_cores, trainFunc)
})

stopCluster(cl)


t0 <- Sys.time()
xgbCVObj <- caret::train(x = r_tFeatureVars,
                         y = r_tTargetVar,
                         method = "xgbTree",
                         metric = "RMSE",
                         trControl = xgbTrainControl,
                         tuneGrid = xgbParamGrid)

t1 <- Sys.time()

t1-t0

clusterApplyLB(cluster, 1:noOfThreads, workfun)


xgbParamGrid[1,]






# Library parallel() is a native R library, no CRAN required
library(parallel)
nCores <- detectCores(logical = FALSE)
nThreads <- detectCores(logical = TRUE)
cat("CPU with",nCores,"cores and",nThreads,"threads detected.\n")

# load the doParallel/doSNOW library for caret cluster use
library(doParallel)
cl <- makeCluster(nCores, type = "PSOCK",outfile="/home/thyarch/projects/recep/umat_output.txt")
registerDoParallel(cl)


getDoParWorkers() 

# random forest regression
xgbCVObj <- train(x = r_tFeatureVars,
                         y = r_tTargetVar,
                         method = "xgbTree",
                         metric = "RMSE",
                         trControl = xgbTrainControl,
                         tuneGrid = xgbParamGrid)
 
stopCluster(cl)
registerDoSEQ()
### END
