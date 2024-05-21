#!/bin/bash
# Battery Notification Script

i=0
avTime=300
cTime=60


while true
do

BatteryCapacity=`cat /sys/class/power_supply/BAT1/capacity`
BatteryStatus=`cat /sys/class/power_supply/BAT1/status`
BatteryDischarging="Discharging"
BatteryCharging="Charging"
BatteryFull="Full"
CriticalAlert=10
NormalAlert=30
LowAlert=50


	if [[ "$BatteryStatus" == "$BatteryDischarging" ]] && [ $BatteryCapacity -le $CriticalAlert ] && [[ $cTime -le 0 ]]; then
		((i=0))
        ((cTime=60))
        ((avTime=300))
        notify-send -u critical "Alert" "Low Battery, we are doomed! ($BatteryCapacity%)" -i battery-level-10-symbolic

    elif [[ "$BatteryStatus" == "$BatteryDischarging" ]] && [ $BatteryCapacity -le $NormalAlert ] && [[ $avTime -le 0 ]]; then
        ((i=0))
        ((cTime=60))
        ((avTime=300))
        notify-send -u normal "Alert" "Battery getting low, charging when? ($BatteryCapacity%)" -i battery-level-30-symbolic

    elif [[ "$BatteryStatus" == "$BatteryDischarging" ]] && [ $BatteryCapacity -le $LowAlert ] && [[ $avTime -le 0 ]]; then
        ((i=0))
        ((cTime=60))
        ((avTime=300))
        notify-send -u low "Alert" "Plug in your computer if possible ($BatteryCapacity%)" -i battery-level-50-symbolic

    elif [[ "$BatteryStatus" == "$BatteryFull" ]] && [[ $i == 1 ]]; then
        notify-send -u low "Alert" "Battery fully charged." -i battery-level-100-symbolic
        ((i++))

    elif [[ "$BatteryStatus" == "$BatteryCharging" ]] && [[ $i == 0 ]]; then
        dunstify -u low "Alert" "Charger connected" -i battery-full-charging-symbolic
        ((i++))

    elif [[ "$BatteryStatus" == "$BatteryDischarging" ]] && [[ $i != 0 ]]; then
        ((i=0))
        dunstify -u low "Alert" "Charger disconnected" -i battery-missing-symbolic
    else
        #notify-send "kurwa"
        if [[ $avTime -le 0 ]] then
            ((avTime=150))
        fi

        if [[ $cTime -le 0 ]] then
            ((cTime=30))
        fi

        ((avTime--))
        ((cTime--))
        sleep 1
	fi
done

