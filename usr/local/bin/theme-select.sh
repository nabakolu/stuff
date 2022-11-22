#!/bin/sh

cd ~/.config/wal/colorschemes/
A=$(find */*.json | dmenu) && wal -s -t --theme $A && theme
