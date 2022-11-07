#!/bin/sh
MUTT_CONFIG="$HOME/.config/mutt"
EMAILS=$(cd "$MUTT_CONFIG/accounts" && find . | tail -n +2 | sed "s/\.\///g; s/\.muttrc$//g")
CHOICE=$(echo "$EMAILS" | dmenu -p "Select address to send from")
[ -z "$CHOICE" ] && exit
ACCOUNT_CONFIG_FILE=$(find "$MUTT_CONFIG/accounts" -name "*$CHOICE*")
exec "$TERMINAL" -e neomutt "$@" -F "$MUTT_CONFIG/muttrc" -F "$ACCOUNT_CONFIG_FILE"
