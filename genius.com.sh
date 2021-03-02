#!/bin/bash

ARG0="$0" source "`dirname $0`/lyrics-search.sh" "${*}"

token="$(cat ${0}.token)"
lurl=( $(curl -k -m5 -H "Authorization: Bearer $token" "https://api.genius.com/search?q=$the_song"  | grep -o 'https[^"]*-lyrics') )

tz "${lurl[@]}"

song_html="$(curl -m5 -k "${lurl[0]}")"

song_text=$(
	echo "$song_html" | \
	grep -o 'Lyrics__Container.*SectionLeaderboard__Container' | \
	sed 's/^[^>]*>//g' | \
	awk -F'SongPage__SectionAnchor' '{print $1;}' RS='' | \
	head -1 | \
	sed 's/<[^>]*$//g'
	)

[ -z "$song_text" ] && \
	song_text=$(echo "$song_html" | \
		awk -F'<div class="lyrics">' '{print $2;}' RS= | \
		sed -e 's/<![^>]*>//g' -e '/^$/d')

print_song
