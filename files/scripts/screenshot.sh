#!/usr/bin/env bash
### screenshot.sh --- using grim and slurp to take screenshots
###
### Usage:
###   screenshot.sh [-c]
###
### Options:
###   -c include cursor in final screenshot

usage() {
    sed -n 's/^### \?//p' "$0"
    exit 1
}

while getopts ':asho:' OPT; do
    case ${OPT} in
	c) include_cursor=1
	   ;;
	\?) usage
	    ;;
	:) echo "Invalid option: -$OPTARG requires an argument" 1>&2
	   usage
	   ;;
    esac
done

shift "$((OPTIND -1))"

flags="$flags -g $(slurp)"

if [ $include_cursor ]; then
    grim="$flags -c"
fi

date=$(date +%Y.%m.%d_%T)
screenshot_dir="$HOME/media/images/screenshots"
screenshot_path="$screenshot_dir/$date.png"
flags="$(echo $flags | xargs)"

grim "$flags" "$screenshot_path"

if [ $? -eq 0 ]; then
    wl-copy < "$screenshot_path"
    guix shell libnotify -- notify-send "Screenshot" "Taken"
else
    guix shell libnotify -- notify-send "Screenshot" "Cancelled"
fi
