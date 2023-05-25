#!/bin/bash 

picos=$(ls /dev/picorce_*)

for pico in ${picos[@]}
do
  bash pico_serial_input.sh pico
done

