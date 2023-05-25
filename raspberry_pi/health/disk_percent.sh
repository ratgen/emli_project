#!/bin/bash 

sudo df -H | grep "$1" | awk '{ print $5}' | head -n 2 | tail -n 1 | sed -e 's/%//g'
