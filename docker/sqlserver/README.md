# start sqlserver

Download and start docker:

```
docker pull mcr.microsoft.com/mssql/server
docker run --restart=always -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=sa-Passw0rd" --name sqlserver -p 1433:1433 -v $(pwd)/sqlserver-data:/var/opt/mssql -d mcr.microsoft.com/mssql/server:latest
```

connect to docker container using sqlcmd:

```
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'sa-Passw0rd'
```


