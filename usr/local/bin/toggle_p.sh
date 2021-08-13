#!/bin/sh
# Toggles a problem on and off

COUNT=$(pgrep -c picom)
if [ "$COUNT" = "0" ]; then
	nohup picom --experimental-backends 0<&- &>/dev/null &
else
	killall picom
fi
