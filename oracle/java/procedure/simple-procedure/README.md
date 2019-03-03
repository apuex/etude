# simple java stored procedure

## install oracle jdbc driver

```
wget -c https://maven.oracle.com/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar
mvn install:install-file \
-Dfile=ojdbc8-12.2.0.1.jar \
-DgroupId=com.oracle.jdbc \
-DartifactId=ojdbc8 \
-Dversion=12.2.0.1 \
-Dpackaging=jar
```
