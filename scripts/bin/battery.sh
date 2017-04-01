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

battery=$(acpi | cut -d' ' -f4 | cut -d% -f1)
status=$(acpi | cut -d' ' -f3)

if [ "$status" == "Discharging," ]; then
    color=#c7979a
else
    color=#92cba3
fi

if [ "$battery" -gt 95 ]; then
    output+="%{F$color}$battery% \uf240 "
elif [ "$battery" -gt 75 ]; then
    output+="%{F$color}$battery% \uf241 "
elif [ "$battery" -gt 50 ]; then
    output+="%{F$color}$battery% \uf242 "
elif [ "$battery" -gt 25 ]; then
    output+="%{F$color}$battery% \uf243 "
elif [ "$battery" -gt 5 ]; then
    output+="%{F$color}$battery% \uf244 "
fi

(echo -e "$output"; sleep $DURATION) | lemonbar -g "$width"x"$height"+$x+$y -f "$FONT" -f $ICONS -B "#99262f32" -d
