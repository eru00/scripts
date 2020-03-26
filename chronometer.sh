#!/bin/bash
# Script that displays the passage of time in the format H:MM:SS with milliseconds precission

invalid_delay_error="Invalid value for delay: \"%s\" is not a real number\nUse \"%s -h\" for help\n"
usage() {
  printf "Script that displays the passage of time in the format H:MM:SS with milliseconds precission\n"
  printf "Usage:\n"
  printf "  $(basename $0) [-d NUMBER | -h]\n"
  printf "Options:\n"
  printf "  -d NUMBER\tSet the delay in seconds between time measures (default is 0.1)\n"
  printf "  -h\t\tDisplay this help message and exit\n"
}

delay=0.1
while getopts d:h option
    do
      case "${option}"
      in
			  d) delay=$(grep -e "^[0-9]*\(\.[0-9]\+\|\)$" <<< "${OPTARG}"); \
           [[ "$delay" == "" ]] && printf "$invalid_delay_error" "${OPTARG}" "$(basename $0)" && exit 1;;
        h) usage; exit 0;;
        *) usage; exit 1;;
      esac
done

tput civis && trap "printf ''; tput cnorm; exit 0" INT EXIT

now=$(date +%s)sec
while true; do
     printf "\r%s" $(TZ=UTC date --date now-$now +%H:%M:%S.%3N) 
     sleep $delay
done

## Alternative way using the SECONDS variable (precission up to seconds)
# while true; do
#   awk -v t=$SECONDS 'BEGIN{t=int(t*1000); printf "\r%d:%02d:%02d", t/3600000, t/60000%60, t/1000%60}'
#   sleep $delay
# done