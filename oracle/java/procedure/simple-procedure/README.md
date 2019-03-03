# simple java stored procedure

## build and copy jar to database

```
$ mvn package
$ scp target/simple-procedure-1.0-SNAPSHOT.jar root@113.108.158.19:/home/master/oracle/oradata/u02/app/oracle/oradata/ORCLCDB/orclpdb1/
```
## create user and grant privileges, create table
```
$ ssh master@113.108.158.19
[master@113.108.158.19 ~]$ docker exec -it oracle-enterprise /bin/bash
[oracle@452596a497a7 orclpdb1]$ sqlplus / as sysdba
SQL> alter session set container=orclpdb1;
SQL> create user wangxy identified by sp8956256;
SQL> grant all privileges to wangxy;
SQL> CREATE TABLE wangxy.sampletable (
    id NUMBER,
    name VARCHAR2(50),
    email VARCHAR2(50),
    CONSTRAINT "SAMPLETABLE_PK" PRIMARY KEY ("ID")
);
SQL> exit
```
## load jar
```
[oracle@452596a497a7 orclpdb1]$ loadjava -u wangxy/passw0rd@orclpdb1 simple-procedure-1.0-SNAPSHOT.jar
[oracle@452596a497a7 orclpdb1]$ exit
[master@113.108.158.19 ~]$ exit
```
## create java procedure
```
[oracle@452596a497a7 orclpdb1]$ sqlplus sys/passw0rd@orclpdb1 as sysdba
SQL> CREATE OR REPLACE procedure wangxy.insert_into_table ( id NUMBER, name VARCHAR2, email VARCHAR2 ) AS
LANGUAGE JAVA NAME 'com.github.apuex.oracle.SimpleProcedure.insert_into_table(int, java.lang.String, java.lang.String)';
SQL> /
SQL> CREATE OR REPLACE procedure wangxy.update_from_table ( id NUMBER, name VARCHAR2, email VARCHAR2 ) AS
LANGUAGE JAVA NAME 'com.github.apuex.oracle.SimpleProcedure.update_from_table(int, java.lang.String, java.lang.String)';
SQL> /
```
## execute java procedure
```
SQL> exec wangxy.insert_into_table(1, 'wangxy', 'xtwxy@hotmail.com');
SQL> exec wangxy.update_from_table(1, 'me', 'my@email.com');
SQL> SELECT * FROM SAMPLETABLE;
```

## unload jar
```
[oracle@452596a497a7 orclpdb1]$ dropjava -u wangxy/passw0rd@orclpdb1 simple-procedure-1.0-SNAPSHOT.jar
```

## install oracle jdbc driver

```
$ wget -c https://maven.oracle.com/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar
$ mvn install:install-file \
-Dfile=ojdbc8-12.2.0.1.jar \
-DgroupId=com.oracle.jdbc \
-DartifactId=ojdbc8 \
-Dversion=12.2.0.1 \
-Dpackaging=jar
```
