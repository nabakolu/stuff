#!/bin/sh
# Toggles a problem on and off

COUNT=$(pgrep -c picom)
if [ "$COUNT" = "0" ]; then
	nohup picom --experimental-backends > /dev/null 2>&1&
else
	killall picom
fi
