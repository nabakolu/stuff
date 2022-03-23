#!/bin/sh

cd ~/.config/wal/colorschemes/
A=$(find */*.json | dmenu) && wal --theme $A && theme
