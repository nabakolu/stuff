#!/bin/sh
# Toggles a problem on and off

COUNT=$(pgrep -c picom)
if [ "$COUNT" = "0" ]; then
	picom --experimental-backends -b
	sleep 1
	COUNT=$(pgrep -c picom)
	if [ "$COUNT" = "0" ]; then
		picom -b
	fi
else
	killall picom
fi
