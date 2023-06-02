#!/bin/bash

ip="$1"
device="$2"

host=localhost
port=1883
username=team13
password=password

plant_alarm=0
pump_alarm=0
needs_water=0

cd "$(dirname "$0")"

while read -u 10 line 
do


  if [[ "$line" == *"plant_alarm"*"1"* ]]; then
    plant_alarm=true
  fi
  if [[ "$line" == *"plant_alarm"*"0"* ]]; then
    plant_alarm=false
  fi
  if [[ "$line" == *"pump_alarm"*"1"* ]]; then
     pump_alarm=true
  fi
  if [[ "$line" == *"pump_alarm"*"0"* ]]; then
     pump_alarm=false
  fi
  
  if [[ "$line" == *"needs_water"*"1"* ]]; then
    ./small_scripts/set_led.sh yellow 1
    needs_water=true
  fi
  if [[ "$line" == *"needs_water"*"0"* ]]; then
    ./small_scripts/set_led.sh yellow 0
    needs_water=false
  fi


  if [[ $plant_alarm == true || $pump_alarm == true ]]; then
    ./small_scripts/set_led.sh red 1
  else
    ./small_scripts/set_led.sh red 0
  fi

  if [[ $needs_water == false && $plant_alarm == false && $pump_alarm == false ]] ; then
    ./small_scripts/set_led.sh green 1
  else
    ./small_scripts/set_led.sh green 0
  fi
  

done 10< <(mosquitto_sub -v -h $host -p $port -u $username -P $password -t team13/watering/$device/sensors/needs_water -t team13/watering/$device/sensors/pump_alarm -t team13/watering/$device/sensors/plant_alarm ) 
