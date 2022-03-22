#!/bin/sh

A=$(find ~/.config/wal/colorschemes/*/*.json | dmenu) && wal --theme $A && theme
