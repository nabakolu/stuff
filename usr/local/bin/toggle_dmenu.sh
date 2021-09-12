#!/bin/sh

if [ "$(dunstctl is-paused)" = "true" ]
then
	dunstctl set-paused false
	notify-send "enabled dunst"
else
	notify-send "disabled dunst"
	sleep 1
	dunstctl close-all
	dunstctl set-paused true
fi
