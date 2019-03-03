#!/bin/bash
# Script to monitor the tcp sockets

while true; do 
	NS=$(netstat -nat)
	clear
	echo "TIME_WAIT"
	echo "$NS" | grep TIME_WAIT | wc -l
	echo "ESTABLISHED"
	echo "$NS" | grep ESTABLISHED | wc -l
	echo "----"
	echo "TOTAL"
	echo "$NS" | wc -l
	sleep 0.6
done
