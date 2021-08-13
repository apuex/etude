#unixodbc

## install mariadb odbc driver

```
$ sudo apt install odbc-mariadb
```

find out odbc driver so:

```
$ sudo dpkg -L odbc-mariadb
/.
/usr
/usr/lib
/usr/lib/x86_64-linux-gnu
/usr/lib/x86_64-linux-gnu/odbc
/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
/usr/share
/usr/share/doc
/usr/share/doc/odbc-mariadb
/usr/share/doc/odbc-mariadb/COPYING.gz
/usr/share/doc/odbc-mariadb/README
/usr/share/doc/odbc-mariadb/changelog.Debian.gz
/usr/share/doc/odbc-mariadb/copyright
```

create a driver template file, mariadb-odbc-driver-template.ini, 
with the following content:

```
[MariaDB ODBC 3.1 Driver]
Description = MariaDB Connector/ODBC v.3.1
Driver = /usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
```

install driver with this driver template:

```
$ sudo odbcinst -i -d -f mariadb-odbc-driver-template.ini
```

## connect to database with connection string

```
isql -k "DRIVER={MariaDB ODBC 3.1 Driver};SERVER=repository;Database=mysql;Uid=root;Pwd=my-secret-pw;Encrypt=no;"
```
or using microsoft sqlserver driver 17:
```
$ isql -k "DRIVER={ODBC Driver 17 for SQL Server};SERVER=repository;Database=gzyd;Uid=sa;Pwd=sa-Passw0rd;Encrypt=no;"
```

## create mariadb odbc datasource

create a database template fire, mariadb-odbc-datasource-template.ini,
with content like this:

```
[some-mysql-server]
Description=MariaDB server
Driver=MariaDB ODBC 3.1 Driver
SERVER=repository
USER=root
PASSWORD=my-secret-pw
DATABASE=mysql
PORT=3306
```

create datasource as system datasource:
```
$ sudo odbcinst -i -s -l -f mariadb-odbc-datasource-template.ini
```

create datasource as user datasource:
```
$ sudo odbcinst -i -s -h -f mariadb-odbc-datasource-template.ini
```

## connect to database with odbc datasource

```
$ isql some-mysql-server
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL> use mysql;
SQLRowCount returns 0
SQL> select user from user;
+---------------------------------+
| user                            |
+---------------------------------+
| root                            |
| mysql.infoschema                |
| mysql.session                   |
| mysql.sys                       |
| root                            |
+---------------------------------+
SQLRowCount returns 5
5 rows fetched
SQL> quit
```
or, using connection string with datasource:

```
$ isql -k DSN=some-mysql-server
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL> quit
```

## creating sqlserver datasource
creating datasource template
```
[gzyd]
Driver=ODBC Driver 17 for SQL Server
Server=repository
Database=gzyd
Encrypt=no
```
install datasource
```
sudo odbcinst -i -s -l -f sqlserver-odbc-datasource-template.ini
```
connecting to sqlserver datasource with username and password:

```
$ isql -k "DSN=gzyd;Uid=sa;Pwd=sa-Passw0rd;"
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL> quit
```

