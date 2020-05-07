#=============================#
#===== xgboost modelling =====#
#=============================#



#----- xgboost modelling -----#


#----- set xgboost model parameters

nrounds = c(100, 300, 500)
max_depth = c(3, 4, 5, 6, 7, 8)
eta = c(0.01, 0.05, 0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.99)
gamma = c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)
colsample_bytree = c(0.25, 0.50, 0.75, 1.00)
min_child_weight = c(1, 3, 5)
subsample = c(0.25, 0.50, 0.75, 1.00)

xgbParamGrid <- expand.grid(nrounds = nrounds,
                            max_depth = max_depth,
                            eta = eta,
                            gamma = gamma,
                            colsample_bytree = colsample_bytree,
                            min_child_weight = min_child_weight,
                            subsample = subsample) %>%
  dplyr::sample_n(10)


#----- set xgboost model training controls

xgbTrainControl <- caret::trainControl(method = "cv",
                                       number = 10,
                                       search = "grid",
                                       allowParallel = TRUE,
                                       verboseIter = TRUE,
                                       returnData = FALSE)


#----- create 'clusters'

no_cores <- detectCores() - 1  
registerDoParallel(cores=no_cores)  
cl <- makeCluster(no_cores, type="FORK", outfile="/home/thyarch/projects/recep/umat_output.txt")

# , type="FORK"
#cl <- makePSOCKcluster(40)
#registerDoParallel(cl)


#----- cross-validation and parameter tuning

t0 <- Sys.time()

xgbCVObj <- caret::train(x = r_tFeatureVars,
                         y = r_tTargetVar,
                         method = "xgbTree",
                         metric = "RMSE",
                         trControl = xgbTrainControl,
                         tuneGrid = xgbParamGrid)

t1 <- Sys.time()
(t1 - t0)


#----- stop 'clusters'

stopCluster(cl)


#----- test the model -----

predictNoShow <- stats::predict(xgbCVObj, r_vFeatureVars)


#----- prepare prediction result data frame

predictionResult <- data.frame(ID = r_vKeyVar) %>% 
  dplyr::mutate(NOSHOW_R = as.integer(r_vTargetVar),
                NOSHOW_P = floor(predictNoShow))

View(predictionResult)





