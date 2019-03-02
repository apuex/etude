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
alter session set container = orclpdb1;

CREATE TABLESPACE history_tbsp
DATAFILE 'pdb1_history_tbsp.dbf' SIZE 10M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

create user wangxy identified by passw0rd default tablespace history_tbsp;
```

## References

- [https://github.com/oracle/docker-images](https://github.com/oracle/docker-images/blob/master/OracleDatabase/SingleInstance/README.md)
