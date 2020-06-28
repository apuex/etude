# bcp

## dump varbinary to file

```
/opt/mssql-tools/bin/bcp "SELECT UIWindow FROM gzyd.dbo.CLogObjUI WHERE LogObjID = 11494" queryout "/root/11494.bin" -S localhost,1433 -U sa -P sa-Passw0rd -c -C RAW
```
