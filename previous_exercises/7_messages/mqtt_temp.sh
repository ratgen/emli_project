#! /bin/bash

while true; do
	temp=$(echo $(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000)))
	mosquitto_pub -h localhost -p 1883 -u team13 -P password -t team13/feeds/cpu_temp -m $temp
	sleep 15
done
