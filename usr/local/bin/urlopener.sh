#!/bin/sh

if [ "$1" = "" ]
then
	file=$(xclip -o -selection clip-board)
else
	file=$1
fi

case "$file" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*)
		setsid -f mpv -quiet "$file" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$file" > "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")" && sxiv -a "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf)
		curl -sL "$file" > "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")" && mupdf "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*mp3)
		setsid -f st -e mocp "$file" >/dev/null 2>&1 ;;
	*)
		[ -f "$file" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$file" >/dev/null 2>&1 || setsid -f "$BROWSER" "$file" >/dev/null 2>&1
esac
