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

