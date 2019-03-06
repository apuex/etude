# How to connect to oracle 12c PDBs

## jdbc url

syntax:
```
jdbc:oracle:thin:<user>/<password>@//<host>:<port>/<service name>
```
if pdb name is `orclpdb1`, the service name maybe `orclpdb1.localdomain`, and `.localdomain` cannot be ommited.

to find out the actual service name, 
```
select name from V$SERVICES;
select name from V$ACTIVE_SERVICES;
```
with sqlplus or sqldeveloper, or using `lsnrctl status`.


## useful sql commands:

```
alter session set container=orclpdb1;
select SYS_CONTEXT ('USERENV','ORACLE_HOME') from dual;
SELECT * FROM V$DATABASE;
SELECT * FROM v$containers;
select * from dba_pdbs;
select name from V$SERVICES;
select name from V$ACTIVE_SERVICES;

SELECT p.PDB_ID, p.PDB_NAME, d.FILE_ID, d.TABLESPACE_NAME, d.FILE_NAME
  FROM DBA_PDBS p, CDB_DATA_FILES d
  WHERE p.PDB_ID = d.CON_ID
  ORDER BY p.PDB_ID;
  
show con_id;
show con_name;

SELECT * FROM WANGXY.table1 OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;
```

