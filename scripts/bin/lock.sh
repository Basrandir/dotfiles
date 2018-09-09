#!/usr/bin/env bash

tmpbg="/tmp/screen.png"


ffmpeg -loglevel quiet -f x11grab -video_size 2560x1600 -y -i "$DISPLAY" -filter_complex "boxblur=10" -vframes 1 $tmpbg

i3lock -i $tmpbg
