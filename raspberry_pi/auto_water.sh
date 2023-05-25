# This script is ran every hour to check if any plants need water and if so, tries to start the pump

# It looks for files in a directory. The name of the file is the id of the pico.
# If a file exists it means that the plant needs water.
search_dir=/home/pi/needs_water

for entry in "$search_dir"/*
do
  filename=$(echo "$entry" | sed 's:.*/::')
  echo "Plant connected to Pico ${filename} needs water"
  $(mosquitto_pub -h localhost -p 1883 -u team13 -P password -t team13/$filename/actuators/pump -m 1)
done
