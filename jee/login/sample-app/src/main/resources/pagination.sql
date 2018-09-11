WITH ActiveAlarms AS  
(  
  SELECT   
    ROW_NUMBER() OVER (ORDER BY AlarmBegin DESC) AS RowNumber, *
    FROM dbo.AAlarmData
    WHERE DataObjectID = 1
)   
SELECT *    
FROM ActiveAlarms   
WHERE RowNumber > 0 AND RowNumber <= 5;  