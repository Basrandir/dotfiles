#!/usr/bin/env bash

repo-remove /home/custompkgs/custom.db.tar $1
sudo pacman -Rs $1
sudo paccache -r
