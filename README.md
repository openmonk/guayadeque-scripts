# guayadeque-mergels.py

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
