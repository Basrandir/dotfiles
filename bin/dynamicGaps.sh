#!/usr/bin/env bash

###

usage() {
    sed -n 's/^### \?//p' "$0"
    exit 1
}

bspc subscribe node_add node_remove | while read -r line; do
    lines=$(bspc query -N -n .local.tiled | wc -l)
    if [ $(bspc query -M -m --names) == "HDMI-A-0" ]; then
	if [ $lines == "1" ]; then
	    bspc config -m HDMI-A-0 -d focused left_padding 1000
	    bspc config -m HDMI-A-0 -d focused right_padding 1000
	elif [ $lines == "2" ]; then
	    bspc config -m HDMI-A-0 -d focused left_padding 500
	    bspc config -m HDMI-A-0 -d focused right_padding 500
	else
	    bspc config -m HDMI-A-0 -d focused left_padding 0
	    bspc config -m HDMI-A-0 -d focused right_padding 0
	fi
    fi
done

	
