#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

value=$(/home/pi/bin/cpu_temperature.sh)
time=$(date +%s)

echo $time,$value >> health.csv
