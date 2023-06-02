#!/bin/bash

color=$1

if [[ "$2" == "0" ]]
then
  setting="off"
elif [[ "$2" == "1" ]]
then
  setting="on"
else 
  exit 1
fi

curl -s "http://192.168.10.222/led/$color/$setting"
