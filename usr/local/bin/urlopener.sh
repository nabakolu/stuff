#!/bin/sh

if [ "$1" = "" ]
then
	file=$(xclip -o -selection clip-board)
else
	file=$1
fi

case "$file" in

	### Videos in mpv
	*.mkv|*.webm|*.mp4|*youtube.com/watch*|*youtu.be/*|*youtube.com/playlist*|*youtu.be/watch*|*ardmediathek.de/video*|*v.redd.it/*|*yewtu.be/watch*)
		setsid -f mpv -quiet "$file" >/dev/null 2>&1 ;;

	### Audio: download mp3 files, youtube-dl from soundcloud and play in xdg-open
	http*://*.mp3)
		wget $file -O /tmp/$(basename $file) -nc
		$TERMINAL -e mocp /tmp/$(basename $file) ;;
	*soundcloud.com*)
		youtube-dl -o "/tmp/%(title)s.%(ext)s" $file --exec xdg-open ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$file" > "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")" && sxiv -a "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf)
		curl -sL "$file" > "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")" && mupdf "/tmp/$(echo "$file" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*)
		setsid -f "$BROWSER" "$file" >/dev/null 2>&1
esac
