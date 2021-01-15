#!/bin/sh
choice=$(echo "Web Browser
mpv" | dmenu -l 20)

if [ "$choice" = "Web Browser" ]; then
	choice="xdg-open"
fi

file=$(xclip -o -selection clip-board)
$choice $file
