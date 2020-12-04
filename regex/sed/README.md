# grep



```
$ ls ddl
CDataObject_Trigger_Delete.sql  CDataObject_Trigger_Insert.sql  
CDataObject_Trigger_Update.sql  CLogicalObject_Trigger_Delete.sql  
CLogicalObject_Trigger_Insert.sql  CLogicalObject_Trigger_Update.sql
$ find ddl -type f -name "*.sql" | sed -n 's/\(^ddl\/\)\(.*\)\(\.sql$\)/\2/p'
CDataObject_Trigger_Insert
CLogicalObject_Trigger_Update
CLogicalObject_Trigger_Delete
CDataObject_Trigger_Update
CLogicalObject_Trigger_Insert
CDataObject_Trigger_Delete
$
```
