#!/usr/bin/env bash

### screenshot.sh --- using maim and slop to take screenshots
###
### Usage:
###   screenshot.sh [-ash] [-o output]
###
### Options:
###   -a screenshot active window
###   -s allows you to select a region to screenshot
###   -h hide cursor in final screenshot

date=$(date +%Y.%m.%d_%T)
screenshot_dir="$HOME/media/images/screenshots"

usage() {
    sed -n 's/^### \?//p' "$0"
    exit 1
}

window_title() {
    local title
    title="$(cat /proc/$(xdotool getwindowpid $(xdotool getactivewindow))/comm)"
    screenshot_dir="$screenshot_dir/$title"
    mkdir -p "$screenshot_dir"
}

while getopts ':asho:' OPT; do
    case ${OPT} in
	a) active_window=1
	   ;;
	s) select_region=1
	   ;;
	h) hide_cursor=1
	   ;;
	\?) usage
	    ;;
	:) echo "Invalid option: -$OPTARG requires an argument" 1>&2
	   usage
	   ;;
    esac
done

shift "$((OPTIND -1))"

if [ $active_window ]; then
    maim_flags="$maim_flags -i $(xdotool getactivewindow)"
    window_title
elif [ $select_region ]; then
    maim_flags="$maim_flags -s"
    window_title
else
    screenshot_dir="$screenshot_dir/fullscreen"
    mkdir -p "$screenshot_dir"
fi

if [ $hide_cursor ]; then
    maim_flags="$maim_flags -u"
fi

screenshot_path="$screenshot_dir/$date.png"
maim_flags="$(echo $maim_flags | xargs)"

if [ $maim_flags ]; then
    maim "$maim_flags" "$screenshot_path"
else
    maim "$screenshot_path"
fi

if [ $? -eq 1 ]; then
    notify-send "Screenshot" "Cancelled"
else
    cat "$screenshot_path" | xclip -selection clipboard -t image/png
    notify-send "Screenshot" "Taken"
fi
