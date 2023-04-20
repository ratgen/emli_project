#!/bin/bash

# Open serial port for reading
stty -F /dev/ttyACM0 115200
exec < /dev/ttyACM0

# Wait for temperature string
while true; do
    read line
    if [[ $line =~ ^[0-9]{2}\.[0-9]*$ ]]; then
        temperature=${line#*:}
        echo $temperature
        break
    fi
done
