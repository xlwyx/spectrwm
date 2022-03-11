#!/bin/bash
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors.

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

##############################
#	    DISK
##############################

hddicon() {
    echo ""
}

hdd() {
  hdd="$(df -h | awk 'NR==4{print $3, $5}')"
  echo -e "HDD:$hdd"
}

##############################
#	    RAM
##############################
memicon() {
    echo ""
}

mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "MEM:$mem"
}

##############################
#	    CPU
##############################
cpuicon() {
    echo ""
}

cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "CPU: $cpu%"
}

##############################
#	    VOLUME
##############################
vol() {
    VOL=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on://g'`
    echo -e "$vol"
}

##############################
#	    NETWORK
##############################
networkicon() {
	wire="$(ip a | grep eno1 | grep inet | wc -l)"
	wifi="$(ip a | grep wlo1 | grep inet | wc -l)"

	if [ $wire = 1 ]; then
		echo "ok"
	elif [ $wifi = 1 ]; then
    		echo "ok"
	else
    		echo "ng"
	fi

}

ipaddress() {
    address="$(ip a | grep .255 | grep -v wlo1 | cut -d ' ' -f6 | sed 's/\/24//')"
    echo "$address"
}

vpnconnection() {
    state="$(ip a | grep tun0 | grep inet | wc -l)"

if [ $state = 1 ]; then
    echo "ﱾ"
else
    echo ""
fi
}

## BATTERY
#bat() {
#batstat="$(cat /sys/class/power_supply/BAT0/status)"
#battery="$(cat /sys/class/power_supply/BAT0/capacity)"
#    if [ $batstat = 'Unknown' ]; then
#    batstat=""
#    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
#    batstat=""
#    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
#    batstat=""
#    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
#    batstat=""
#    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
#    batstat=""
#    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
#    batstat=""
#    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
#    batstat=""
#fi
#
#echo "$batstat  $battery %"
#}

clockicon() {
    CLOCK=$(date '+%I')

    case "$CLOCK" in
    "00") icon="" ;;
    "01") icon="" ;;
    "02") icon="" ;;
    "03") icon="" ;;
    "04") icon="" ;;
    "05") icon="" ;;
    "06") icon="" ;;
    "07") icon="" ;;
    "08") icon="" ;;
    "09") icon="" ;;
    "10") icon="" ;;
    "11") icon="" ;;
    "12") icon="" ;;
    esac

    echo "$(date "+$icon")"
}

dateinfo() {
    echo "$(date "+%b %d %Y (%a)")"
}

clockinfo() {
    echo $(date "+%I:%M%p")
}


      SLEEP_SEC=2
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do
        # echo "$(cpu) | $(mem) | $(hdd) | $(vpn) $(network) | $(vol) "
	echo "+@fg=1; $(cpuicon) +@fg=0; $(cpu)\
    +@fg=1; $(dateinfo) +@fg=4; $(clockicon) +@fg=0; $(clockinfo)\
    +@fg=1; $(memicon) +@fg=0; $(mem)\
    +@fg=3; $(hddicon) +@fg=0; $(hdd)\
    +@fg=4; $(networkicon) +@fg=0; $(ipaddress) +@fg=4; $(vpnconnection)\
    +@fg=0; $(vol)\
    "
        sleep $SLEEP_SEC
		done
