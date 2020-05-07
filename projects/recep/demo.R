library(sparklyr)
library(dplyr)
library(nycflights13)
library(Lahman)
library(pryr)
library(ggplot2)
library(DBI)


Sys.setenv(SPARK_HOME='/usr/lib/spark')
Sys.setenv(JAVA_HOME='/etc/alternatives/jre')
sc <- spark_connect(master = "yarn-client")


iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)

# drop the table
dplyr::db_drop_table(sc, "flights")
colnames(flights_tbl)

spark_version(sc)
sessionInfo()

 
dim(flights_tbl)

pryr::object_size(flights_tbl)


head(select(flights_tbl, distance, origin))

head(filter(flights_tbl, arr_delay > 30))

flights_tbl_aggr <- 
  flights_tbl %>%
  group_by(origin) %>%
  summarise(mean = mean(distance),
            count = n(),
            sum = sum(distance))
head(flights_tbl_aggr)


 
flights_tbl %>% filter(dep_delay == 2)

delay <- flights_tbl %>% 
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>% 
  arrange(tailnum) %>%
  collect()



ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area(max_size = 2)


batting_tbl %>%
  select(playerID, yearID, teamID, G, AB:H) %>%
  arrange(playerID, yearID, teamID) %>%
  group_by(playerID) %>%
  filter(min_rank(desc(H)) <= 2 & H > 0)


# use SQL  
iris_preview <- dbGetQuery(sc, "SELECT * FROM iris LIMIT 10")
iris_preview



# Machine learning example using Spark MLlib

# copy the mtcars data into Spark
mtcars_tbl <- copy_to(sc, mtcars)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear regression model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))
fit

summary(fit)

# get the 10th row in test data
car <- tbl_df(partitions$test) %>% slice(10)
# predict the mpg 
predicted_mpg <- car$cyl * fit$coefficients["cyl"] + car$wt * fit$coefficients["wt"] + fit$coefficients["(Intercept)"]

# print the original and the predicted
sprintf("original mpg = %s, predicted mpg = %s", car$mpg, predicted_mpg)
