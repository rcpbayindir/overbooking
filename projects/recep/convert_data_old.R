#install.packages("data.table")
require(data.table)
library(dplyr)

rm(list = ls())
dsc_colClassNames <-c("character",
                      "character",
                      "integer",
                      "character",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character",
                      "integer",
                      "integer",
                      "integer")
ond_colClassNames <-c("character",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character",
                      "integer",
                      "integer",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character",
                      "character",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "character",
                      "character",
                      "integer",
                      "integer",
                      "integer",
                      "character",
                      "integer",
                      "integer",
                      "integer",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character",
                      "integer",
                      "integer",
                      "character",
                      "character",
                      "character",
                      "character")



dcs_16 <- as.data.table(fread("data/DCS_2016.csv", sep = ";", header= TRUE,colClasses = dsc_colClassNames)) 
dcs_17 <- as.data.table(fread("data/DCS_2017.csv", sep = ";", header= TRUE,colClasses = dsc_colClassNames))
dcs_18 <- as.data.table(fread("data/DCS_2018.csv", sep = ";", header= TRUE,colClasses = dsc_colClassNames))


ond_16 <- as.data.table(fread("data/OND_2016.csv", sep = ";", header= TRUE ,colClasses = ond_colClassNames))
ond_17 <- as.data.table(fread("data/OND_2017.csv", sep = ";", header= TRUE ,colClasses = ond_colClassNames))
ond_18 <- as.data.table(fread("data/OND_2018.csv", sep = ";", header= TRUE ,colClasses = ond_colClassNames))




dim(dcs_16) # 6416   12 
dim(dcs_17) # 6324   12 
dim(dcs_18) # 4055   12 

dim(ond_16) # 270996     47 
dim(ond_17) # 724216     47
dim(ond_18) # 507830     47 


names(dcs_16) <- toupper(gsub(" ", "_", names(dcs_16)))
names(dcs_17) <- toupper(gsub(" ", "_", names(dcs_17)))
names(dcs_18) <- toupper(gsub(" ", "_", names(dcs_18)))


names(ond_16) <- toupper(gsub(" ", "_", names(ond_16)))
names(ond_17) <- toupper(gsub(" ", "_", names(ond_17)))
names(ond_18) <- toupper(gsub(" ", "_", names(ond_18)))


ond_16[,`:=`(FLIGHY_CODE= paste0(ond_16$CRRCODE,"0",ond_16$FLTNUM))]
ond_17[,`:=`(FLIGHY_CODE= paste0(ond_17$CRRCODE,"0",ond_17$FLTNUM))]
ond_18[,`:=`(FLIGHY_CODE= paste0(ond_18$CRRCODE,"0",ond_18$FLTNUM))]

dcs_keycolumns <- c("DCS_ARR_APT", "DCS_DEP_APT",
                    "DCS_DEP_YMD_LMT","DCS_DEP_TIME_LMT",
                    "DCS_FLIGHT_NO","DCS_SELL_CLASS",
                    "DCS_PNR_NO")

ond_keycolumns <- c("SEGDSTN","SEGORGN",
                    "LOCDPTDATE","LOCDPTTIME",
                    "FLIGHY_CODE","CLSCODE",
                    "RECLOC")

ond_dcs_16 <- merge(ond_16,dcs_16, all.x=TRUE ,by.x=ond_keycolumns
                    ,by.y=dcs_keycolumns)


ond_dcs_17  <- merge(ond_17,dcs_17,all.x=TRUE ,by.x=ond_keycolumns
                     ,by.y=dcs_keycolumns)


ond_dcs_18  <- merge(ond_18,dcs_18, all.x=TRUE,by.x=ond_keycolumns
                     ,by.y=dcs_keycolumns)




dim(ond_dcs_16) # 12661    53 
dim(ond_dcs_17) # 31510    53
dim(ond_dcs_18) # 20826    53


ond_dcs_full <- rbind(ond_dcs_16,ond_dcs_17,ond_dcs_18)

dim(ond_dcs_full) #  1503042      53 


ond_dcs_full <- ond_dcs_full %>% 
  mutate(WEEKDAY =   toupper(format(as.Date( as.character(ond_dcs_full$LOCDPTDATE) , "%Y%m%d"), format = "%a")) )


ond_dcs_full <- ond_dcs_full %>% 
  mutate(WEEKDAY_NUM = as.numeric(format(as.Date( as.character(ond_dcs_full$LOCDPTDATE) , "%Y%m%d"), format = "%u"))-1
  )

#ond_dcs_full$WEEKDAY <-   toupper(format(as.Date( as.character(ond_dcs_full$LOCDPTDATE) , "%Y%m%d"), format = "%a"))
#ond_dcs_full$WEEKDAY_NUM <- as.numeric(format(as.Date( as.character(ond_dcs_full$LOCDPTDATE) , "%Y%m%d"), format = "%u"))-1


ond_dcs_full <- ond_dcs_full %>% 
  mutate(DEPARTURE_TIME_RANGE = case_when(
    .$LOCDPTTIME >= 0 & .$LOCDPTTIME <= 559   ~ "EM",
    .$LOCDPTTIME >= 600 & .$LOCDPTTIME <= 959   ~ "M",
    .$LOCDPTTIME >= 1000 & .$LOCDPTTIME <= 1359   ~ "MD",
    .$LOCDPTTIME >= 1400 & .$LOCDPTTIME <= 1859   ~ "A",
    .$LOCDPTTIME >= 1900 & .$LOCDPTTIME <= 2359   ~ "E"  )
  )

as.Date(as.character(ond_dcs_full$LOCDPTDATE), "%Y%m%d") -
  as.Date(as.character(ond_dcs_full$CRDATE), "%Y%m%d")


ond_dcs_full <- ond_dcs_full %>% 
  mutate(PNR_CREATION_DTD =difftime(as.Date(as.character(ond_dcs_full$LOCDPTDATE), "%Y%m%d") , as.Date(as.character(ond_dcs_full$CRDATE), "%Y%m%d") , units = c("days"))
  )



ond_dcs_full <- ond_dcs_full %>% 
  mutate(PNR_CREATION_DTD_RANGE = case_when(
    .$PNR_CREATION_DTD < 0  ~  -1,
    .$PNR_CREATION_DTD >= 0 & .$PNR_CREATION_DTD <= 7   ~  10,
    .$PNR_CREATION_DTD >= 8 & .$PNR_CREATION_DTD <= 30   ~ 9,
    .$PNR_CREATION_DTD >= 31 & .$PNR_CREATION_DTD <= 60   ~ 8,
    .$PNR_CREATION_DTD >= 61 & .$PNR_CREATION_DTD <= 90   ~ 7,
    .$PNR_CREATION_DTD >= 91 & .$PNR_CREATION_DTD <= 120   ~ 6,
    .$PNR_CREATION_DTD >= 121 & .$PNR_CREATION_DTD <= 150   ~ 5,
    .$PNR_CREATION_DTD >= 151 & .$PNR_CREATION_DTD <= 180   ~ 4,
    .$PNR_CREATION_DTD >= 181 & .$PNR_CREATION_DTD <= 210   ~ 3,
    .$PNR_CREATION_DTD >= 211 & .$PNR_CREATION_DTD <= 270   ~ 2,
    .$PNR_CREATION_DTD >= 271   ~ 1
  )
  )


ond_dcs_full <- ond_dcs_full %>% 
  mutate(PNR_LAST_MODIFIED_DTD =difftime(as.Date(as.character(ond_dcs_full$LOCDPTDATE), "%Y%m%d") , as.Date(as.character(ond_dcs_full$XACTDATE), "%Y%m%d") , units = c("days"))
  )

ond_dcs_full <- ond_dcs_full %>% 
  mutate(PNR_LAST_MODIFIED_DTD_RANGE = case_when(
    .$PNR_LAST_MODIFIED_DTD < 0  ~  -1,
    .$PNR_LAST_MODIFIED_DTD >= 0 & .$PNR_LAST_MODIFIED_DTD <= 7   ~  10,
    .$PNR_LAST_MODIFIED_DTD >= 8 & .$PNR_LAST_MODIFIED_DTD <= 30   ~ 9,
    .$PNR_LAST_MODIFIED_DTD >= 31 & .$PNR_LAST_MODIFIED_DTD <= 60   ~ 8,
    .$PNR_LAST_MODIFIED_DTD >= 61 & .$PNR_LAST_MODIFIED_DTD <= 90   ~ 7,
    .$PNR_LAST_MODIFIED_DTD >= 91 & .$PNR_LAST_MODIFIED_DTD <= 120   ~ 6,
    .$PNR_LAST_MODIFIED_DTD >= 121 & .$PNR_LAST_MODIFIED_DTD <= 150   ~ 5,
    .$PNR_LAST_MODIFIED_DTD >= 151 & .$PNR_LAST_MODIFIED_DTD <= 180   ~ 4,
    .$PNR_LAST_MODIFIED_DTD >= 181 & .$PNR_LAST_MODIFIED_DTD <= 210   ~ 3,
    .$PNR_LAST_MODIFIED_DTD >= 211 & .$PNR_LAST_MODIFIED_DTD <= 270   ~ 2,
    .$PNR_CREATION_DTD >= 271   ~ 1
  )
  )



ond_dcs_full[["MT_DCS_PSGR_COUNT"]][is.na(ond_dcs_full[["MT_DCS_PSGR_COUNT"]])] <-0

save(ond_dcs_full, file = "noshowData.RData")
