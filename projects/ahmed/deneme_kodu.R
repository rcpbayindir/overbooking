library(sparklyr)
suppressPackageStartupMessages(library("dplyr"))
library(nycflights13)
library(Lahman)


#spark_disconnect(sc)


conf <- spark_config()

conf$spark.driver.cores <- 8
conf$spark.driver.memory <- "20G"
conf$spark.executor.cores <- 16
conf$spark.executor.memory <- "20G"
conf$spark.executor.instances <- 16
conf$sparklyr.log.console <- TRUE
conf$sparklyr.verbose <- TRUE
sc <- spark_connect(
  master = "yarn-client",
  app_name = "test_client",
  version = "2.4.0",
  config = conf,
  spark_home = "/usr/lib/spark/"
)

spark_session(sc)


iris_tbl <- copy_to(sc, iris)
flights_tbl<-copy_to(sc, nycflights13::flights,"flights")



src_tbls(sc)


flights_tbl%>%filter(dep_delay==2)



delay <- flights_tbl %>% group_by(tailnum) %>% summarise(
  count = n(),
  dist = mean(distance),
  delay = mean(arr_delay)
) %>% filter(count > 20,
             dist <
               2000,!is.na(delay)) %>% collect()
head(delay)



# copy mtcars into spark
mtcars_tbl <- copy_to(sc, mtcars)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))

summary(fit)


iris_tbl %>% spark_apply(function(e) sapply(e[,1:4], jitter))

iris_tbl %>%
  spark_apply(
    function(e) data.frame(2 * e$Sepal_Length, e),
    names = c("2xS_len", colnames(iris_tbl)))

