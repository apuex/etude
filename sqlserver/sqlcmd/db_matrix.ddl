DROP DATABASE IF EXISTS matrix
GO

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

USE matrix
GO

DROP SCHEMA IF EXISTS matrix
GO

CREATE SCHEMA matrix AUTHORIZATION dbo
GO

DROP USER IF EXISTS matrix
GO

-- DROP LOGIN IF EXISTS matrix
DROP LOGIN matrix
GO

CREATE LOGIN matrix WITH PASSWORD='my-Secret-pw'
GO

CREATE USER matrix FOR LOGIN matrix WITH DEFAULT_SCHEMA=matrix
GO

DROP ROLE IF EXISTS masters
GO

CREATE ROLE masters AUTHORIZATION dbo
GO

ALTER ROLE masters ADD MEMBER matrix
GO

-- ALTER ROLE masters DROP MEMBER matrix
-- GO

USE matrix
GO

DROP TABLE IF EXISTS matrix.transposed
GO

CREATE TABLE matrix.transposed(id INT NOT NULL, value INT)
GO

ALTER TABLE matrix.transposed WITH CHECK
ADD CONSTRAINT matrix_transposed_pk PRIMARY KEY CLUSTERED (id)
GO

-- ALTER TABLE matrix.transposed DROP CONSTRAINT IF EXISTS matrix_transposed_pk
-- GO


