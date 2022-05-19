#!/bin/sh

curr="$(setxkbmap -print | grep nodeadkeys)"
if [ $curr=="" ]
then
	setxkbmap -layout de -variant nodeadkeys -option lv3:caps_switch
	notify-send "Deactivated dead keys"
else
	setxkbmap -layout de -option lv3:caps_switch
	notify-send "Activated dead keys"
fi
