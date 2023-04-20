#!/bin/bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sh /home/pi/4_io/led_blink.sh & 
sh /home/pi/4_io/power_off.sh & 
