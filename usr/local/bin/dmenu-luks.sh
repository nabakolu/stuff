#!/bin/sh


blockdevs="$(lsblk -rpo "name,fstype" | grep crypto_LUKS | awk '{print  $1;}')"
choices=""
for dev in $blockdevs
do
    output="$(udisksctl info --block-device "$dev" | grep "CleartextDevice:            '/'")"
    if [ "$output" = "" ]
    then
        choices="$choices
lock   $dev"
    else
        choices="$choices
unlock $dev"
    fi
done

choice="$(echo "$choices" | tail -n +2 | dmenu | awk '{print $1 " -b " $2;}')"

if [ "$choice" = "" ]
then
    exit
fi


PS1=""
${TERMINAL:-st} -c FLOATING -g 60x1 -e udisksctl $choice || notify-send "Dmenu-LUKS" "Failure"