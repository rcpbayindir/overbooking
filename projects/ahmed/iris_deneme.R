library(dplyr)
library(tidyverse)

data(iris)

summary(iris)

nrow(iris)


iris_mul <- iris[rep(seq_len(nrow(iris)), 1000000), ]
nrow(iris_mul)

iris_mul2 <- iris_mul %>%
  dplyr::select_if(is.numeric)

iris_col <- iris_mul2[, rep(seq_len(ncol(iris_mul2)), 50)]

iris_col[, "Species"] <- iris_mul[, "Species"]


iris_col

object.size(iris_col)
#format(iris_col, standard = "SI", units="MB")

iris_grouped <- iris_col %>%
  group_by(Species)

iris_grouped

iris_summ <- iris_grouped %>%
  summarise_all(mean)

iris_summ