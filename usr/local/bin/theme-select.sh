#!/bin/sh

A=$(wal --theme | dmenu | awk '{print $2}') && wal --theme $A && theme
