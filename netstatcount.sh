#!/bin/bash
# Script to monitor the tcp sockets

ALL=0
PORT=""
REFRESH=1
STATUSES=( )
while getopts p:r:as: option
    do
        case "${option}"
        in
			p) PORT=":${OPTARG}";;
			a) ALL=1;;
			r) REFRESH=${OPTARG};;
			s) STATUSES=("${STATUSES[@]}" "${OPTARG}");;
        esac
done

[ ${#STATUSES[@]} -eq 0 ] && STATUSES=( TIME_WAIT ESTABLISHED )
[ $ALL -eq 1 ] && STATUSES=( TIME_WAIT ESTABLISHED LISTEN SYN-SENT SYN-RECEIVED FIN-WAIT-1 FIN-WAIT-2 CLOSE-WAIT CLOSING LAST-ACK CLOSED )
while true; do 
	NS=$(netstat -nat); [[ "$PORT" ]] && NS=$(echo "$NS" | grep $PORT) 
	clear
	for STATUS in "${STATUSES[@]}"
	do
		echo "$STATUS $PORT" ; echo "$NS" | grep $STATUS | wc -l
	done
	echo "----"
	echo "TOTAL"
	echo "$NS" | wc -l
	sleep $REFRESH
done
