
# Basic info

A collection of scripts dedicated to Guayadeque Music Player

---

## guayadeque-mergels.py

A small script to merge guayadeque `lyrics_sources.xml` without overwriting custom lyrics sources.

```bash

# get new lyrics_sources.xml
cd /tmp
wget https://raw.githubusercontent.com/anonbeat/guayadeque/master/defconfig/lyrics_sources.xml

# get the script
wget https://raw.githubusercontent.com/openmonk/guayadeque-scripts/main/guayadeque-mergels.py
chmod +x guayadeque-mergels.py

# backup
cp ~/.guayadeque/lyrics_sources.xml ~/.guayadeque/lyrics_sources.xml.bk

# merge the config
./guayadeque-mergels.py /tmp/lyrics_sources.xml > merged_lyrics_sources.xml
cp merged_lyrics_sources.xml ~/.guayadeque/lyrics_sources.xml

```

---

## Lyrics scraping scripts 

All scripts below can be added as GMP lyrics sources with ``{al} {tl}`` command line options.

---

### Installation

```bash
wget https://github.com/openmonk/guayadeque-scripts/archive/main.zip
unzip main.zip
cd guayadeque-scripts-main/
ls *.sh | grep -v lyrics-search.sh | xargs -I__ echo '<lyricsource type="command" enabled="true" name="__" source="'`pwd`'/__ {al} {tl}"/>' | xargs -d'\n' | sed 's/[.[\*^$\/"]/\\&/g' | xargs -d'\n' -I__ sed -i.backup 's/<\/lyricsources>/__<\/lyricsources>/g' ~/.guayadeque/lyrics_sources.xml
```

---

### ``musixmatch.com.sh``

Grabs lyrics from https://www.musixmatch.com

### ``genius.com.sh``

Grabs lyrics from https://www.genius.com

*Note that genius.com search engine can give wrong search results so it is recommended to use the script with lowest priority possible*

In order to use the script you need to setup genius.com account, register a new API client (via https://genius.com/api-clients), Generate Access Token and save it to ``genius.com.sh.token`` file.

---

### ``pesni.guru.sh``

Grabs lyrics from https://www.pesni.guru

---

### ``tekst-pesni.online.sh``

Grabs lyrics from https://www.tekst-pesni.online

*Note that tekst-pesni.online search engine can give wrong search results so it is recommended to use the script with lowest priority possible*
