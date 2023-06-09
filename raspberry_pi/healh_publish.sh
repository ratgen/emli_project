#!/bin/bash
#
host=localhost
port=1883
username=team13
password=password

while true; do
  /bin/bash /home/pi/documents/emli_project/raspberry_pi/health/available_ram.sh | mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/health/available_ram_percentage -s
  /bin/bash /home/pi/documents/emli_project/raspberry_pi/health/cpu_temperature.sh | mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/health/cpu_temperature -s
  /bin/bash /home/pi/documents/emli_project/raspberry_pi/health/current_cpu_load.sh | mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/health/current_cpu_load_percentage -s
  /bin/bash /home/pi/documents/emli_project/raspberry_pi/health/disk_percent.sh | mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/health/disk_usage_percent -s
  sleep 2
done
