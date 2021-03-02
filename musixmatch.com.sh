#!/bin/bash

ARG0="$0" source "`dirname $0`/lyrics-search.sh" "${*}"

song_url=$(curl -m10 -k 'https://www.musixmatch.com/search/'$the_song'/tracks#' | grep -o -e '/lyrics/[^"]*' | grep -v /play | sort | uniq | head -1)

tz "$song_url"

song_html="$(curl -k -m10 'https://www.musixmatch.com'$song_url)"

song_text=$(echo "$song_html" | awk -F'"body":"' '{print $2;}' RS='' | awk -F'","' '{print $1;}' RS='')

song_text=$(echo "$song_text" | sed 's/\\n/<br \/>/g')

print_song

