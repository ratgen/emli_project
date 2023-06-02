#!/bin/bash

color=$1

if [[ "$2" == "0" ]]; then
  setting="off"
elif [[ "$2" == "1" ]]
  setting="on"
else 
  exit 1
fi

curl "http://192.168.10.222/led/$color/$setting"
