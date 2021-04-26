#!/usr/bin/env bash

### wallpaper.sh --- Allow setting wallpapers using pqiv and setroot
###
### Usage:
###   wallpaper.sh
###
### Options:
###   -h show this help

usage() {
    sed -n 's/^### \?//p' "$0"
}

while getopts ':h' OPT; do
    case ${OPT} in
	h) usage
	   exit 0
	   ;;
	\?) echo "Invalid option: -$OPTARG" 1>&2
	    exit 1
	    ;;
    esac
done

shift "$((OPTIND -1))"


RESOLUTION=$(xrandr | grep 'current' | awk '{print $8$9$10}' | cut -d, -f1)
WALLPAPER_DIR="$HOME/media/images/wallpapers"

pqiv --auto-montage-mode --thumbnail-persistence=yes --thumbnail-size=256x256 --bind-key="w { command(setroot --store -t $1) }" $WALLPAPER_DIR/*
