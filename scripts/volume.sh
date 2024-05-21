#!/bin/sh
down() {
pamixer -d 5
volume=$(pamixer --get-volume)
[$volume -gt 0 ] && volume=`expr $volume`
dunstify "VOLUME: $volume%" -h int:value:"$volume" -i audio-volume-medium-symbolic -u normal -r 9991
}

up() {
pamixer -i 5
volume=$(pamixer --get-volume)
[ $volume -lt 100 ] && volume=`expr $volume`
dunstify "VOLUME: $volume%" -h int:value:"$volume" -i audio-volume-high-symbolic -u normal -r 9991
}

mute() {
muted="$(pamixer --get-mute)"
if $muted; then
  pamixer -u
  dunstify "UNMUTED" -i audio-volume-high-symbolic -u normal -r 9991
else
  pamixer -m
  dunstify "MUTED" -i audio-volume-muted-symbolic -u normal -r 9991
fi
}


case "$1" in
  up) up;;
  down) down;;
  mute) mute;;
esac
