#!/bin/bash

ARG0="$0" source "`dirname $0`/lyrics-search.sh" "${*}"

lurl=$(curl -k -m15 "https://tekst-pesni.online/?s=$the_song"  | grep -o 'Результаты поиска.*' | grep -o 'entry-title.*</h2>' | grep -o 'https://tekst-pesni.online[^"]*')
tz "${lurl}"

song_html="$(curl -k -m15 "${lurl}")"
tz "${song_html}"

song_text=$(echo ${song_html} | awk -F'</h2><p>' '{print $3;}' RS='' | awk -F'</p><p><iframe' '{print $1;}' RS='' | sed 's/<\/\?p>/<br \/>/g')
tz "${song_text}"

printf "$song_text" | iconv -f UTF-8 -t UTF-16 >&3
