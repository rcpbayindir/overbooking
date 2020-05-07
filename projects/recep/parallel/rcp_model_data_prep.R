#======================================#
#===== prepare xgboost model data =====#
#======================================#



#----- generate unique IDs for unique flights -----#

r_xgbModelData <- r_modelData %>% 
  dplyr::mutate(ID = dplyr::group_indices(., FLIGHT_NUM, DEP_DATE, DEP_TIME))

r_uniqueID_LT <- r_xgbModelData %>% 
  dplyr::select(FLIGHT_NUM,
                DEP_DATE,
                DEP_TIME,
                ID)


#----- remove obsolete variables and variable type conversion -----#

r_xgbModelData <- r_xgbModelData %>% 
  dplyr::select(-FLIGHT_NUM,
                -DEP_DATE,
                -DEP_TIME) %>% 
  dplyr::mutate(DEP_MONTH = forcats::fct_explicit_na(DEP_MONTH),
                DOW = forcats::fct_explicit_na(DOW),
                DEP_TIME_RANGE = forcats::fct_explicit_na(DEP_TIME_RANGE))


#----- xgboost model data formatting -----#

#----- shuffle data

r_xgbModelData <- r_xgbModelData[sample(1:nrow(r_xgbModelData)), ]


#xgb_nrow <- nrow(r_xgbModelData)

#r_xgbModelData2 <- r_xgbModelData %>% sample_n(xgb_nrow)


#----- one-hot encoding of model data categorical variables

ohEncoder <- caret::dummyVars(~.,
                              data = r_xgbModelData,
                              sep = ".",
                              fullRank = TRUE)

r_xgbModelData <- data.frame(stats::predict(ohEncoder, newdata = r_xgbModelData))


rm(ohEncoder)


#----- generate train-test and validation data sets

r_tData <- r_xgbModelData %>%
  dplyr::sample_frac(0.85)

r_vData <- dplyr::setdiff(r_xgbModelData, r_tData)


#----- extract key, target and feature variables

r_tKeyVar <- r_tData$ID
r_tTargetVar <- r_tData$CURRENT_NOSHOW
r_tFeatureVars <- r_tData %>% 
  dplyr::select(-ID,
                -CURRENT_NOSHOW)

r_vKeyVar <- r_vData$ID
r_vTargetVar <- r_vData$CURRENT_NOSHOW
r_vFeatureVars <- r_vData %>% 
  dplyr::select(-ID,
                -CURRENT_NOSHOW)


#----- generate data matricies for xgboost modelling

r_tMat <- xgboost::xgb.DMatrix(data = as.matrix(r_tFeatureVars),
                               label = r_tTargetVar)

r_vMat <- xgboost::xgb.DMatrix(data = as.matrix(r_vFeatureVars),
                               label = r_vTargetVar)

