#!/bin/sh

# Power menu script using tofi

ShutOff="⏻ Shutdown"
Reboot="⏽ Reboot"
Lock="⏼ Lock"
Suspend="⏾ Suspend"
LogOut="⭘ Log Out"


CHOSEN=$(printf "$ShutOff\n$Reboot\n$Lock\n$Suspend\n$LogOut" | rofi -dmenu -theme-str '@import "pwmenu.rasi"')

sleep 1
case "$CHOSEN" in
    $ShutOff) poweroff ;;
    $Reboot) reboot ;;
	$Lock) playerctl -a pause; swaylock;;
	$Suspend) systemctl suspend;;
	$LogOut) hyprctl dispatch exit ;;
	*) exit 1 ;;
esac
