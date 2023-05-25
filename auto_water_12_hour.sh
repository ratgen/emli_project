# This script is ran once every 12 hours. It detects Picos attached to the Raspberry Pi and sends a
# message to the MQTT broker to start the pump for each Pico.

search_dir=/dev

for entry in "$search_dir"/*
do
  filename=$(echo "$entry" | sed 's:.*/::')
  if [[ $filename == pi_* ]]
  then
     id=$(echo $filename | cut -c 4-)
     $(mosquitto_pub -h localhost -p 1883 -u team13 -P password -t team13/watering/$id/actuators/pump -m 1)
  fi
done