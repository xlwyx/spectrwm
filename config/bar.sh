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
    echo ""
}

mem() {
  mem=`free | awk '/Mem/ {printf "%dM/%dM\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "$mem "
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
    echo -e "$VOL"
}

##############################
#	    NETWORK
##############################
networkicon() {
	wire="$(ip a | grep eth0 | grep inet | wc -l)"
	wifi="$(ip a | grep wlan0 | grep inet | wc -l)"

	if [ $wire = 1 ]; then
		echo "ok"
	elif [ $wifi = 1 ]; then
    		echo "ok"
	else
    		echo "ng"
	fi
}

ipaddress() {
	    address="$(ip a | grep .255 | grep -v wlp2s0 | cut -d ' ' -f6 | sed 's/\/24//')"
	        echo "$address"
}


#############################
#           DATE
#############################

dateinfo() {
    echo "$(date "+%b %d %Y (%a)")"
}

dateicon() {
    echo -e " "
}

clockinfo() {
    echo $(date "+%I:%M%p")
}


      SLEEP_SEC=2
      #loops forever outputting a line every SLEEP_SEC secs
      while :; do
	echo "$(cpuicon) $(cpu)\
    || $(dateinfo) $(dateicon) $(clockinfo)\
    || $(vol)\
    || $(memicon) $(mem)\
    || $(hddicon) $(hdd)\
    || $(networkicon) $(ipaddress)\
    "
        sleep $SLEEP_SEC
		done
