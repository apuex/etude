# How to run oracle on docker

## Run

```
docker run --name <container name> \
-p <host port>:1521 -p <host port>:5500 \
-e ORACLE_SID=<your SID> \
-e ORACLE_PDB=<your PDB name> \
-e ORACLE_PWD=<your database passwords> \
-e ORACLE_CHARACTERSET=<your character set> \
-v [<host mount point>:]/opt/oracle/oradata \
```

```
mkdir -p oracle/oradata
chown -R 54321:54321 oracle/
docker run -d --name oracle-enterprise \
-p 1521:1521 -p 5000:5000 -p 5500:5500 \
-e ORACLE_SID=ORCLCDB \
-e ORACLE_PDB=ORCLPDB1 \
-e ORACLE_PWD=passw0rd \
-e ORACLE_CHARACTERSET=AL32UTF8 \
-v $(pwd)/oracle/oradata:/ORCL \
docker.io/store/oracle/database-enterprise:12.2.0.1
```

## Connect to PDBs

```
[oracle@43c6342b94b9 /]$ sqlplus scott/tiger@"(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.0.184)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orclpdb1.localdomain)))"

SQL*Plus: Release 12.2.0.1.0 Production on Wed Sep 4 03:58:06 2019

Copyright (c) 1982, 2016, Oracle.  All rights reserved.

Last Successful login time: Tue May 21 2019 09:40:38 +00:00

Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

SQL> exit
Disconnected from Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production
[oracle@43c6342b94b9 /]$ sqlplus sys/sp8956256@"(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.0.184)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orclpdb1.localdomain)))" as sysdba

SQL*Plus: Release 12.2.0.1.0 Production on Wed Sep 4 03:58:42 2019

Copyright (c) 1982, 2016, Oracle.  All rights reserved.

Last Successful login time: Thu Apr 18 2019 05:17:49 +00:00

Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

SQL> exit
Disconnected from Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production
[oracle@43c6342b94b9 /]$ sqlplus sys@"(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=192.168.0.184)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orclpdb1.localdomain)))" as sysdba

SQL*Plus: Release 12.2.0.1.0 Production on Wed Sep 4 03:58:57 2019

Copyright (c) 1982, 2016, Oracle.  All rights reserved.

Enter password: 
Last Successful login time: Wed Sep 04 2019 03:58:42 +00:00

Connected to:
Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production

SQL> 
```

## Create table spaces

```
alter session set container = orclpdb1;

CREATE TABLESPACE history_tbsp
DATAFILE 'pdb1_history_tbsp.dbf' SIZE 10M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

create user wangxy identified by passw0rd default tablespace history_tbsp;
```

## References

- [https://github.com/oracle/docker-images](https://github.com/oracle/docker-images/blob/master/OracleDatabase/SingleInstance/README.md)
