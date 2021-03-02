#!/bin/bash

# helper script. sourced from other scripts

ISO8601_TS_CMD="date +%FT%T"

no_debug() {
	echo '_0_no_false_' | \
		grep -iq "_${DEBUG:=$( [ -f /dev/shm/lyrics-debug ] && echo yes || echo no)}_"
}

if [ -z "${MY_DEBUG_LOG}" ]; then
	no_debug && \
		DEBUG_LOG=${DEBUG_LOG:-/dev/null} || \
		DEBUG_LOG="${DEBUG_LOG:-${ARG0}.$(${ISO8601_TS_CMD}).debug.log}"
	exec 3>&1
	MY_DEBUG_LOG="${DEBUG_LOG}" "${ARG0}" "${*}" > "${DEBUG_LOG}" 2>&1
	MY_EXIT_CODE=$?
	exit ${MY_EXIT_CODE}
fi

MY_NAME=$(basename "${ARG0}")

lo() {
        echo "${MY_NAME} @ $(${ISO8601_TS_CMD}) :: ${*}"
}

( echo -n >&3 ) 2>/dev/null || exec 3>&1

ou() {
	lo "STDOUT>>>${*}<"
        echo "${*}" >&3
}

lo "MY_DEBUG_LOG=${MY_DEBUG_LOG}"

lo "params=<<${*}>>"

tz() {
	[ -z "$*" ] && exit 1
}

strip_tags() {
	echo "${*}" | \
		xargs -d'\n' | \
		sed 's/<\/\?\(br\|p\)\s*\/\?>/NEW_LINE_HERE/gi' | \
		sed 's/<[^>]*>//g' | \
		sed 's/NEW_LINE_HERE/<br \/>/g'
}

print_song() {
	[ "$song_text" = "Tbf shortly" ] && exit 1
	tz "$song_text"
	strip_tags "$song_text" | iconv -f UTF-8 -t UTF-16 >&3
}

tz "$*"

no_debug || set -x

the_song=$(echo -ne "$*" | tr '!@#$^&*()_=+/|`~\\-' ' ' | xargs | sed 's/[ +]\+/+/g')

tz "${the_song}"
