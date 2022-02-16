#!/bin/bash
# baraction.sh for spectrwm status bar

## DISK
hdd() {
  hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  echo -e "HDD:$hdd"
}

## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "MEM:$mem%"
}

## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

## NETWORK
net() {
  wifi="$(ip a | grep wlo1 | grep inet | wc -l)"

  if [ $wifi = 1 ]; then
	  echo "ok"
  else
	  echo "ng"
  fi
}    

## BATTERY
##bat() {
#batstat="$(cat /sys/class/power_supply/BAT0/status)"
#battery="$(cat /sys/class/power_supply/BAT0/capacity)"
#    if [ $batstat = 'Charging' ]; then
#    batstat="^"
#    elif [ $batstat = 'Discharging' ]; then
#    batstat="v"
#    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
#    batstat=""
#    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
#    batstat=""
#    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
#    batstat=""
#    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
#    batstat=""
#    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
#    batstat=""
#    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
#    batstat=""
#fi

#echo "$batstat  $battery %"
##}

## VOLUME
vol() {
    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "$vol"
}

SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
	echo -e "$(cpu) $(mem) $(hdd) $(net) $(vol)"
	sleep $SLEEP_SEC
done
