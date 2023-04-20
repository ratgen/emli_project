#!/bin/bash 

tail -n 60 /var/www/html/log.txt | awk '{ ORS="," }; {print $5 }' | sed 's/,$/\n/'
