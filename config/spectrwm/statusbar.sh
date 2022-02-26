#!/bin/bash
# minimal statusbar info : Spandan # github.com/spandanji

hddroot(){
	hddroot="$(df -h | awk 'NR==4{print $3, $5}')"
	echo -e "ROOT : $hddroot"
}

#hddhome(){
#	hddhome="$(df -h | awk 'NR==9{print $3, $5}')"
#	echo -e "HOME : $hddhome"
#}

mem(){
	mem="$(free | awk '/Mem/ {printf "%d MiB / %d MiB : %d%\n", $3 / 1024.0, $2 / 1024.0,  $3/$2 *100}')"
	echo -e "MEM : $mem"
}

cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
  	sleep 0.5
  	read cpu a b c idle rest < /proc/stat

	total=$((a+b+c+idle))
 	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo -e "CPU: $cpu%"
}

vol(){
	x="$(pamixer --get-mute)"
	if [ $x = "true" ]
	then
		vol="MUTE"
	else
		vol="$(pamixer --get-volume)"
	fi
	echo -e "VOL: $vol"
}

SLEEP_SEC=0.5
while :; do
	echo "$(cpu) | $(hddroot) | $(mem) | $(vol)" 
	sleep $SLEEP_SEC
done

