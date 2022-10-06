#!/bin/sh

fn=$(ls -t /tmp/videos/ | dmenu)
if [ "$fn" != "" ] 
then
    mpv "/tmp/videos/$fn"
fi
