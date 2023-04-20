result=$(python /home/pi/4_io/read_mcp3008.py)
curl "https://api.thingspeak.com/update?api_key=5IIRKK0OYSL1EELA&field1="$result

