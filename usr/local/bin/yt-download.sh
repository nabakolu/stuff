#!/bin/sh

mkdir -p /tmp/videos
title=$(yt-dlp "$1" --sponsorblock-remove all -o "/tmp/videos/%(title)s.%(ext)s" --print-json --no-warnings | jq -r .title)
action=$(notify-send "yt-dlp" "Finished downloading\n $title" -A watch)

if [ "$action" = "0" ]
then
    fn=$(ls "/tmp/videos/" | grep "$title")
    mpv "/tmp/videos/$fn"
fi
