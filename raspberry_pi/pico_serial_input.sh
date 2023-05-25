#!/bin/bash

device="/dev/pi_"$1

stty -F $device 115200
exec < $device

host=localhost
port=1883
username=team13
password=password

# Wait for temperature string
while true; do
  IFS=',' read -ra line 
  
  pump_alarm=${line[1]}
  if [ "$pump_alarm" == "0" ]; then
    pump_alarm=1
  else
    pump_alarm=0
  fi

  threshold=60

  if [[ "${line[2]}" -ne " " ]] ; then
    if [[ "${line[2]}" -lt "$threshold" ]] ; then
      touch "/home/pi/needs_water/"$1 2> /dev/null
      mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/needs_water -m "1"
    else
      rm "/home/pi/needs_water/"$1 2> /dev/null
      mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/needs_water -m "0"
    fi
  fi


  if [ ${#line[@]} != 0 ]; then
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/plant_alarm -m ""${line[0]}
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/pump_alarm -m ""$pump_alarm
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/moisture -m ""${line[2]}
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/watering/$1/sensors/light -m ""${line[3]}
  fi
done
