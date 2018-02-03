#!/usr/bin/env bash

DIR=$HOME/media/
unset files; declare -a files
unset names; declare -a names
while IFS= read -r -u3 -d $'\0' file; do
    files+=( "$file" )        # or however you want to process each file
    fn=$(basename "${file}")
    names+=( "$fn" )
done 3< <(find "${DIR}" -type f -print0)


function lists() {
    OLDIFS=${IFS}
    IFS='|'
    for n in "${names[@]}"
    do
        echo "${n}"
    done
    IFS=${OLDIFS}
}

ID=$(lists | rofi -dmenu -format "i" -i)

if [ -n "${ID}" ]; then
    xdg-open "${files[${ID}]}"
fi
