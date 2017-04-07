#!/bin/bash

DURATION=2
ICONS=FontAwesome:size=26
FONT="Fira Mono:size=20"

resultion_x=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '16 p')
resultion_y=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '17 p')

width=380
height=100

x=$(( $(( resultion_x / 2 )) - $(( width / 2 )) ))
y=$(( $(( resultion_y / 2 )) - $(( height / 2 )) ))

output='%{c} '

volume=$(pactl list sinks | grep "Volume:" | awk '{print $5}' | head -n1 | cut -d% -f1)
muted=$(pactl list sinks | grep "Mute" | awk '{print $2}')

color=#92cba3

if [ "$1" == "raise" ]; then
    output+="%{F$color}$volume% \uf028 "
elif [ "$1" == "lower" ]; then
    if [ "$volume" -lt 5 ]; then
        output+="%{F$color}\uf026 "
    else
        output+="%{F$color}$volume% \uf027 "
    fi
elif [ "$1" == "toggle" ]; then
    if [ "$muted" == "yes" ]; then
        output+="%{F$color}\uf026 "
    else
        output+="%{F$color}\uf028 "
    fi
fi

(echo -e "$output"; sleep $DURATION) | lemonbar -g "$width"x"$height"+$x+$y -f "$FONT" -f "$ICONS" -B "#262f32" -d
