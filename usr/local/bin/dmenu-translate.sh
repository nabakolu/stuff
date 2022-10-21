#!/bin/bash

AVAIL_LANGS="de:en
en:de
de:fr
fr:de"

TRANS_LANGS=$(echo "$AVAIL_LANGS" | dmenu -p fromLang:toLang)
RES=$(printf "" | dmenu -p "Translate:" | trans "$TRANS_LANGS" -show-original n -show-original-phonetics n -show-translation y -show-translation-phonetics n -show-prompt-message n -show-languages n -show-original-dictionary n -show-dictionary n -show-alternatives Y -no-ansi -no-pager | sed '4q;d' | tr , "\n" | awk '{$1=$1};1' | dmenu -p "Select Result" | sed '1q;d')
printf "%s" "$RES" | xclip -i -selection clipboard 
