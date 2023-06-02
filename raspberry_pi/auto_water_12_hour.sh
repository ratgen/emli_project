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
