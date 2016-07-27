#!/bin/sh -x

export SPARK_CLASSPATH=`find $EXTLIB_DIR -type f | grep .jar$ | xargs | sed -e 's/ /:/g'`
echo $SPARK_CLASSPATH

export SPARK_JAVA_OPTS='-XX:-UseGCOverheadLimit -XX:+UseConcMarkSweepGC -Xmx4g -Xms2g -XX:MaxPermSize=256m'

/opt/${SPARK_DIR}/bin/spark-submit --supervise --class org.apache.spark.sql.hive.thriftserver.HiveThriftServer2
