#!/bin/sh

HEXCODE=$(colors -n 32 -erp $1)

[ -e $HOME/.Xresources.d/colors ] && rm $HOME/.Xresources.d/colors

CPT=0
for CODE in $HEXCODE
do
    printf '#define S_BASE%d %s\n' "$CPT" "$CODE"
    CPT=$(expr $CPT + 1)
done | column -t >> $HOME/.Xresources.d/colors

for CODE in $HEXCODE
do
    echo $CODE | hex2col
done

xrdb $HOME/.Xresources
