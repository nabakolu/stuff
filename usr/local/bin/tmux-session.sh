#!/bin/bash

function tmux_sessions()
{
    tmux list-session -F '#S'
}

TMUX_SESSION=$( (echo new; tmux_sessions) | dmenu -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
    NAME=$(echo "" | dmenu -p "Enter session name")
    if [ "$NAME" = "" ]
    then
        $TERMINAL -e tmux new-session &
    else
        $TERMINAL -e tmux new-session -s "$NAME" &
    fi
elif [[ -z "${TMUX_SESSION}" ]]; then
    echo "Cancel"
else
    $TERMINAL -e tmux attach -t "${TMUX_SESSION}" &
fi
