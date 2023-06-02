search_dir=/home/pi/needs_water

for entry in "$search_dir"/*
do
  filename=$(echo "$entry" | sed 's:.*/::')
  echo "${filename}"
  $(mosquitto_pub -h localhost -p 1883 -u team13 -P password -t team13/$filename/actuators/pump -m 1)
done
