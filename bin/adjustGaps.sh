#!/usr/bin/env bash

### adjustGaps.sh --- quickly adjust left/right padding for widescreen monitors
###
### Usage:
###   adjustGaps.sh [-lr] <PIXEL_VALUE>
###
### Options:
###   -l adjust left side padding
###   -r adjust right side padding

usage() {
    sed -n 's/^### \?//p' "$0"
    exit 1
}

while getopts ':l:r:' OPT; do
    case ${OPT} in
	l) left_adjust=$OPTARG
	   ;;
	r) right_adjust=$OPTARG
	   ;;
	\?) usage
	    ;;
	:) echo "Invalid option: -$OPTARG requires an argument" 1>&2
	   ;;
    esac
done

shift "$((OPTIND -1))"

if [ $left_adjust ]; then
    bspc config -m focused -d focused left_padding $left_adjust
fi

if [ $right_adjust ]; then
    bspc config -m focused -d focused right_padding $right_adjust
fi
