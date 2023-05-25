#!/bin/bash

host=localhost
port=1883
username=team13
password=password

while true; do
  transmitted=$(cat /sys/class/net/wlan0/statistics/tx_bytes)
  received=$(cat /sys/class/net/wlan0/statistics/rx_bytes)

  transmitted_err=$(cat /sys/class/net/wlan0/statistics/tx_errors)
  received_err=$(cat /sys/class/net/wlan0/statistics/tx_errors)

  mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/network/transmitted_bytes -m ""$transmitted
  mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/network/received_bytes -m ""$received
  mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/network/transmit_errors -m ""$transmitted_err
  mosquitto_pub -h $host -p $port -u $username -P $password -t team13/raspberry/network/receive_errors -m ""$received_err
  sleep 2
done
