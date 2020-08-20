#!/usr/bin/env bash

### removePackage.sh --- properly remove packages installed using AURUTILS
###
### Usage:
###   removePackage.sh <pkgname>
###
### Options:
###   <pkgname>   Name of the AUR package to remove

help() {
    sed -n 's/^### \?//p' "$0"
}

if [[ $# == 0 ]] || [[ "$1" == "-h" ]]; then
    help
    exit 1
fi

repo-remove /home/custompkgs/custom.db.tar $1
sudo pacman -Rs $1
sudo paccache -r
