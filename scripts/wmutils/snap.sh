#!/bin/sh
# 
# kalq
# simple wrapper that snaps the active window to the desired position

ROOT=$(lsw -r)
ROOT_W=$(wattr w $ROOT)
ROOT_H=$(wattr h $ROOT)

# Defining variables for the active window
WIN=$(pfw)
WIN_X=$(wattr x $WIN)
WIN_Y=$(wattr y $WIN)
WIN_W=$(wattr w $WIN)
WIN_H=$(wattr h $WIN)

WIN_B=4 # window border width * 2
        # because it's not included in the window dimension provided
        # by wattr

while getopts "hjkl" opt ; do
    case $opt in
        h)  # snaps window to the left of the root window
            wtp 0 $WIN_Y $WIN_W $WIN_H $WIN
            break
            ;;
        j) # snaps window to the bottom of the root window
            wtp $WIN_X $((ROOT_H - WIN_H - WIN_B)) $WIN_W $WIN_H $WIN
            break
            ;;
        k) # snaps window to the top of the root window
            wtp $WIN_X 0 $WIN_W $WIN_H $WIN
            break
            ;;
        l) # snaps window to the right of the root window
            wtp $((ROOT_W - WIN_W - WIN_B)) $WIN_Y $WIN_W $WIN_H $WIN
            break
            ;;
    esac
done
