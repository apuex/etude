# Hyper Microservices


## Memory Consumption

```
cat /proc/9670/smaps | grep -i rss |  awk '{Total+=$2} END {print Total/1024" MB"}'
cat /proc/9670/smaps | grep -i pss |  awk '{Total+=$2} END {print Total/1024" MB"}'
``` 


