APP_USER=hadoop
APP_GROUP=hadoop
INSTALL_DIR=/mnt/lib/spark-jobserver
LOG_DIR=/mnt/var/log/spark-jobserver
PIDFILE=spark-jobserver.pid
JOBSERVER_MEMORY=1G
SPARK_VERSION=1.6.0
SPARK_HOME=/usr/lib/spark
SPARK_CONF_DIR=/etc/spark/conf
HADOOP_CONF_DIR=/etc/hadoop/conf
YARN_CONF_DIR=/etc/hadoop/conf
SCALA_VERSION=2.10.5
MANAGER_JAR_FILE="$appdir/spark-job-server.jar"
MANAGER_CONF_FILE="$(basename $conffile)"
MANAGER_EXTRA_JAVA_OPTIONS=
  MANAGER_EXTRA_SPARK_CONFS="spark.yarn.submit.waitAppCompletion=false|spark.files=$appdir/log4jcluster.properties,$conffile"
MANAGER_LOGGING_OPTS="-Dlog4j.configuration=log4j-cluster.properties"