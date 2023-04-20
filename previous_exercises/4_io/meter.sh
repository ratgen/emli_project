#!/bin/bash

while [ true ]
do
	res=$(python read_mcp3008.py)
	echo $res
	angle=$(($res * 180 / 1023))
	echo "angle"$angle
	python servo_control.py $angle
	sleep 2
done
