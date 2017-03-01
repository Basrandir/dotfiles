#!/bin/bash

terminal="st"

if [ -z $(xdotool search --classname "dropdown") ]; then
    bspc rule -a $terminal:dropdown state=floating hidden=on border=off sticky=on
    
    # Use of xtoolwait is recommended instead of the until-loop.
    # One or the other is needed to wait for the terminal to be
    # mapped to a window before continuing the script.
    # xtoolwait, as the name implies, does not work with wayland.
    #xtoolwait "$terminal" -c "$terminal" -n dropdown
    ($terminal -c $terminal -n dropdown &); until [ $(bspc query -N -n .hidden | tail -n1) ]; do :; done

    # find the newest hidden terminal
    wid=$(bspc query -N -n .hidden | tail -n1)

    width=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '16 p')
    height=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '17 p')

    xdotool windowmove $wid 0 0
    xdotool windowsize $wid $(expr $width - 4) $(expr $height / 3)

    compton-trans -w $wid -o 90
    echo $wid

    # Reveal the terminal once all the geometric changes are complete
    bspc node $wid -g hidden=off -f
    
    bspc rule -r $terminal:dropdown
else
    wid=$(bspc query -N -n .hidden | tail -n1)

    # toggle visibility of dropdown menu
    bspc node $wid -g hidden -f
fi
