#/bin/bash

echo $(ps aux | LC_NUMERIC="C" awk {'sum+=$3; printf("%f\n",sum) '} | tail -n 1 | cut -c -4)
