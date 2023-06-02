#!/bin/bash

ip=$1


while (true); do
	count=$(curl -s "http://$ip/button/a/count")
	sleep 0.2

	if ((count == "1"));
	then
		sleep 2
		count=$(curl -s "http://$ip/button/a/count")
		if !((count == "1"));
		then
			echo 1
		fi
	fi
done


