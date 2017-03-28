#!/bin/bash

DURATION=2
FONT=FontAwesome:size=16

resultion_x=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '16 p')
resultion_y=$(bspc query -T -m | grep -oE "[0-9]{0,4}" | sed -n '17 p')

width=380
height=100

x=$(( $(( resultion_x / 2 )) - $(( width / 2 )) ))
y=$(( $(( resultion_y / 2 )) - $(( height / 2 )) ))

output='%{c} '

IFS=':' read -r -a array <<< "$(bspc wm -g)"

for i in "${array[@]}"
do
    case $i in
        O*)
            output+='%{F#c17e82}\uf111 '
            ;;
        F*)
            output+='%{F#c17e82}\uf10c '
            ;;
        o*)
            output+='%{F#81b5d1}\uf111 '
            ;;
        f*)
            output+='%{F#81b5d1}\uf10c '
            ;;
    esac
done

(echo -e "$output"; sleep $DURATION) | lemonbar -g "$width"x"$height"+$x+$y -f $FONT -B "#99262f32" -d
