#!/bin/sh -x

# Environment variables of package versions
MYSQL_JDBC_VERSION=5.1.38
PG_JDBC_VERSION=9.4.1208
STRATIO_VERSION=0.11.1
SCALA_VERSION=2.10
CASBAH_VERSION=3.1.1
MONGO_HADOOP_VERSION=1.5.2
MONGO_DRIVER_VERSION=3.2.2

# Mysql JDBC driver
wget http://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_JDBC_VERSION}/mysql-connector-java-${MYSQL_JDBC_VERSION}.jar
# PostgreSQL JDBC driver
wget https://jdbc.postgresql.org/download/postgresql-${PG_JDBC_VERSION}.jar
# Mongo-Stratio dependendies
wget http://repo1.maven.org/maven2/org/mongodb/casbah-commons_${SCALA_VERSION}/${CASBAH_VERSION}/casbah-commons_${SCALA_VERSION}-${CASBAH_VERSION}.jar
wget http://repo1.maven.org/maven2/org/mongodb/casbah-core_${SCALA_VERSION}/${CASBAH_VERSION}/casbah-core_${SCALA_VERSION}-${CASBAH_VERSION}.jar
wget http://repo1.maven.org/maven2/org/mongodb/casbah-query_${SCALA_VERSION}/${CASBAH_VERSION}/casbah-query_${SCALA_VERSION}-${CASBAH_VERSION}.jar
wget http://repo1.maven.org/maven2/com/stratio/datasource/spark-mongodb_${SCALA_VERSION}/${STRATIO_VERSION}/spark-mongodb_${SCALA_VERSION}-${STRATIO_VERSION}.jar
wget http://repo1.maven.org/maven2/org/mongodb/mongo-hadoop/mongo-hadoop-core/${MONGO_HADOOP_VERSION}/mongo-hadoop-core-${MONGO_HADOOP_VERSION}.jar
wget http://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/${MONGO_DRIVER_VERSION}/mongo-java-driver-${MONGO_DRIVER_VERSION}.jar

