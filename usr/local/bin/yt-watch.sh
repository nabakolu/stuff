#!/bin/sh

fn=$(ls -t /tmp/videos/ | dmenu)
mpv "/tmp/videos/$fn"
