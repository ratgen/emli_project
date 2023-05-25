#!/bin/bash

host=localhost
port=1883
username=team13
password=password

pump_alarm=0
plant_alarm=0

while read -u 10 line 
do
  if [[ "$line" == *"plant_alarm"*"1"* ]]; then
    plant_alarm=1
  fi
  if [[ "$line" == *"plant_alarm"*"0"* ]]; then
    plant_alarm=0
  fi

  if [[ "$line" == *"pump_alarm"*"1"* ]]; then
    pump_alarm=1
  fi

  if [[ "$line" == *"pump_alarm"*"0"* ]]; then
    pump_alarm=0
  fi

  if [[ "$line" == *"pump 1"  ]] && [ $pump_alarm == 0 ] && [ $plant_alarm == 0 ]   ; then
    echo p > /dev/ttyACM0
  fi

done 10< <(mosquitto_sub -v -h $host -p $port -u $username -P $password -t team13/actuators/pump -t team13/sensors/pump_alarm -t team13/sensors/plant_alarm ) 
