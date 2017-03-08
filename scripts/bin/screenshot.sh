#!/bin/bash
sleep 2

# get window title
date=$(date +%Y.%m.%d_%H:%M:%S)
location="$HOME/media/images/screenshots/"

if [ "$1" == select ]; then
    title="$(cat /proc/$(xdotool getwindowpid $(xdotool getwindowfocus))/comm)"
    [ -d "$location/$title" ] || mkdir "$location/$title"
    maim -s "$location/$title/$date.png"
elif [ "$1" == fullscreen ]; then
    title="fullscreen"
    [ -d "$location/$title" ] || mkdir "$location/$title"
    maim "$location/fullscreen/$date.png"
fi

if [ "$2" == imgur ]; then
    imgur.sh "$location/$title/$date.png"
fi
