#!/bin/sh
# Toggles a problem on and off

COUNT=$(pgrep -c picom)
if [ "$COUNT" = "0" ]; then
	picom -b
else
	killall picom
fi
