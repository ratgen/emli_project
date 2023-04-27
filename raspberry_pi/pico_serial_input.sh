#!/bin/bash

stty -F /dev/ttyACM0 115200
exec < /dev/ttyACM0

host=localhost
port=1883
username=team13
password=password

# Wait for temperature string
while true; do
  IFS=',' read -ra line 
  if [ ${#line[@]} != 0 ]; then
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/sensors/plant_alarm -m ""${line[0]}
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/sensors/pump_alarm -m ""${line[1]}
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/sensors/moisture -m ""${line[2]}
    mosquitto_pub -h $host -p $port -u $username -P $password -t team13/sensors/light -m ""${line[3]}
  fi
done
