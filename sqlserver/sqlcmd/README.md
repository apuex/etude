# sqlcmd basics

## Display Databases

1. by quering `sys.databases` table

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> SELECT name FROM sys.databases
2> GO
```

2. by execute system procedure `sp_databases`

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> EXEC sp_databases
2> GO
```

## Display Schemas 

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> SELECT name FROM sys.schemas
2> GO
```

## Create Schema

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> CREATE SCHEMA matrix AUTHORIZATION dbo
2> GO
```

## Drop Schema

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> DROP SCHEMA IF EXISTS matrix
2> GO
```

## Create Database

eg. create a database with name matrix:

1. Create a file named `db_matrix.ddl`, with the code below as content:

```
CREATE DATABASE matrix ON 
  PRIMARY (
    NAME       = matrix_data,
    FILENAME   = '/var/opt/mssql/data/matrix_data.mdf',
    SIZE       = 10MB,
    MAXSIZE    = UNLIMITED,
    FILEGROWTH = 10MB
  )
  LOG ON (
    NAME       = matrix_log,
    FILENAME   = '/var/opt/mssql/log/matrix_log.ldf',
    SIZE       = 10MB,
    MAXSIZE    = UNLIMITED,
    FILEGROWTH = 10MB
  )

GO
```

2. execute the script `db_matrix.ddl` using `sqlcmd` to create database.

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd -i db_matrix.ddl
```

## Drop Database

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> DROP DATABASE IF EXISTS matrix
2> GO
```

## Shrink Datafiles

To shrink data/log files, use `dbcc shrinkfile`:
```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> USE matrix
2> GO
3> DBCC SHRINKFILE (N'matrix\_Log', 1)
4> GO
```

if just purge/truncate log file only, sqlserver versions newer or equal to 2008 no longer support `truncate\_only` again.

to purge/truncate log file contents, first change logging level to simple, then `shrinkfile`, and then change logging level back again.

```
/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U sa -P sa-Passw0rd
1> USE matrix
2> GO
3> ALTER DATABASE matrix SET RECOVERY SIMPLE;
4> GO
5> DBCC SHRINKFILE (N'matrix\_Log', 1)
6> GO
7> ALTER DATABASE matrix SET RECOVERY FULL;
8> GO
```

Be sure that your database is not online, since recovery model not comforms the required model.

