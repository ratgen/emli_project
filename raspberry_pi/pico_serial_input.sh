#!/bin/bash

stty -F /dev/ttyACM0 115200
exec < /dev/ttyACM0

# Wait for temperature string
while true; do
  IFS=',' read -ra line 

  mosquitto_pub -h localhost -p 1883 -t team13/sensors/plant_alarm -m ${line[0]}
  mosquitto_pub -h localhost -p 1883 -t team13/sensors/pump_alarm -m ${line[1]}
  mosquitto_pub -h localhost -p 1883 -t team13/sensors/moisture -m ${line[2]}
  mosquitto_pub -h localhost -p 1883 -t team13/sensors/light -m  ${line[3]}

done
