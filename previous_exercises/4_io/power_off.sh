count=0
while [ true ]
do
	res=$(sh /home/pi/4_io/read_switch.sh)
	if [ $res -eq 1 ]
	then
		echo "shutting in $((3 - $count))"
		count=$(($count + 1))
	else
		echo "not shutting down"
		count=0
	fi

	if [ $count -gt 2 ]
	then
		echo "shutting"
		poweroff
	fi	
	sleep 1
done
