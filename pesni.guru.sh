#!/bin/bash

ARG0="$0" source "`dirname $0`/lyrics-search.sh" "${*}"

lurl=( $(curl -k -m5 "https://pesni.guru/search/$the_song"  | grep -o '\/text\/[^"]*') )
tz "${lurl[@]}"

song_html="$(curl -k -m5 "https://pesni.guru${lurl[0]}" | grep /search/)"
tz "${song_html}"

song_text=$(echo ${song_html} | grep -o '</div>.*')
tz "${song_text}"

song_text=$(echo "${song_text%<a href*}"  | sed 's/<br>/LINE_BREAK/g' | sed -e 's/<[^>]*>//g' -e 's/LINE_BREAK/<br \/>/g')

print_song
