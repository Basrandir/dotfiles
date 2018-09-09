#!/bin/bash

# source colors
#. "$HOME/.local/bin/color-parser"

# create notify title
title="<span foreground='$MAGENTA'>Now Playing</span>"

# get current album
notify-send "$title" "$(mpc current)"
