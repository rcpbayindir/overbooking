
library(DBI)
iris_preview <- dbGetQuery(sc, "SELECT * FROM iris LIMIT 10")
iris_preview


sc2 <- spark_connect(master = "http://10.0.1.134:8998", method = "livy")


spark_disconnect_all()
