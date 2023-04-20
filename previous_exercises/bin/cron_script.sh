#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

echo "time: $(date +%s) parameter: $1" >> cron_log.txt
