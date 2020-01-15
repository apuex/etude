ps -ef | grep myproject | head -1 | awk '{ print $2 }' | xargs -I {} pmap {} | tail -1 | awk '{ print $2}'

