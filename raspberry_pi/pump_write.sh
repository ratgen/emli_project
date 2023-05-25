#!/bin/bash

while read -u 10 line
do
  if [ "$line" == "1" ]; then
    echo p > /dev/ttyACM0
  fi
done 10< <(mosquitto_sub -h localhost -p 1883 -u team13 -P password -t team13/actuators/pump)
