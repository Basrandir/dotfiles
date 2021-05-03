#!/usr/bin/env bash

#readarray -t song

while read -r line; do
    song+=("$line")
done

ARTIST="${song[0]}"
TITLE="${song[1]}"
ALBUM="${song[2]}"

if [[ $ARTIST == "Epica" ]] && [[ $ALBUM == "Omega" ]]; then
    ALBUM="Ωmega"
    TITLE=$(echo "$TITLE" | cut -d- -f1 | xargs)
fi

echo "$ARTIST"
echo "$TITLE"
echo "$ALBUM"
