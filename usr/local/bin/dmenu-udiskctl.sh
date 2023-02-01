#!/bin/bash

#DMENU=${DMENU:-dmenu}
DMENU="dmenu -l 10"

DEV_LABEL="/dev/disk/by-label/"
TMP="/tmp/dmnt-udisksctl-$(date +%s)"

trap "rm -f $TMP" EXIT

opt_mount_type=0
opt_ignore_filter=0
opt_notify=0
udiskctl_cmd="mount"

usage() {
    cat <<-EOF
	usage: dmenu-udiskctl [-mudihn]
	     -m Mount devices
	     -u Unmount devices
	     -d Select by device rather than by label
	     -i Ignore filter and list all devices in /dev (with -d)
	     -n Pass udiskctl output to notify-send
	     -h Print help
	EOF

}

dmenu_mnt() {
    if [[ $opt_mount_type -eq 1 ]]; then
        prompt="$udiskctl_cmd by-device:"
        if [[ $opt_ignore_filter -eq 0 ]]; then
            res="$(find /dev -maxdepth 1 -not -type d -name "s[dr]*" -or -name "hd*" | cut -d'/' -f3 | ${DMENU} -p "$prompt")"
        else
            res="$(find /dev -maxdepth 1 -not -type d | cut -d'/' -f3 | ${DMENU} -p "$prompt")"
        fi

        path="/dev/$res"

        [[ -z $res ]] && echo "Cancelled." && exit
    else
        prompt="$udiskctl_cmd by-label:"
        res="$(find $DEV_LABEL* | cut -d'/' -f5 | ${DMENU} -p "$prompt")"

        path="$DEV_LABEL/$res"

        [[ -z $res ]] && echo "Cancelled." && exit
    fi

    path="$(realpath "$path")"
    udisksctl $udiskctl_cmd -b "$path" > "$TMP" 2>&1
    exitc=$?

    if [[ $opt_notify -eq 1 ]]; then
        case $exitc in
            0) urgency="normal";;
            *) urgency="critical";;
        esac
        notify-send -u $urgency "$(<$TMP)"
    else
        cat "$TMP"
    fi
}

while getopts ':mudhin' opt; do
    case "$opt" in
        m) ;;
        u) udiskctl_cmd="unmount";;
        d) opt_mount_type=1;;
        i) opt_ignore_filter=1;;
        h) usage && exit;;
        n) opt_notify=1;;
        /?) echo "Unrecognized command: $OPTARG";;
    esac
done

dmenu_mnt && exit
