#!/bin/sh
choice=$(echo "firefox --new-tab
mpv" | dmenu -l 20)
file=$(xclip -o)
$choice $file
