#!/bin/bash

ip="$1"
device="$2"

cd "$(dirname "$0")"

if [[ $ip != "" ]]
then 
	echo "queriying ip: "$ip
else
	echo "No ip specified, exiting"
	exit 1
fi

if [[ $device != "" ]]
then
	echo "using device id: "$device
else
	echo "No device specified, exiting"
	exit 1
fi

host=localhost
port=1883
username=team13
password=password

./small_scripts/get_btn.sh $ip | mosquitto_pub -h $host -p $port -u $username -P $password -t "team13/watering/$device/actuators/pump" --stdin-line
