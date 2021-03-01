#!/bin/python3

import xml.etree.ElementTree as ET
import os, sys

n_lss = ET.fromstringlist(len(sys.argv)>1 and open(sys.argv[1], 'r').readlines() or sys.stdin.readlines()).findall('lyricsources/lyricsource')
o_xml = ET.parse(os.getenv('GDQ_LYRICS_SOURCES', os.getenv('HOME','') + '/.guayadeque/lyrics_sources.xml'))

for n_ls in n_lss:
	o_lss = o_xml.findall('lyricsources/lyricsource[@name="%s"]' % (n_ls.attrib['name'], ))
	if not o_lss:
		o_xml.append(n_ls)
	else:
		for o_ls in o_lss:
			enabled = o_ls.attrib['enabled']
			o_ls.clear()
			o_ls.attrib = n_ls.attrib
			o_ls.text = n_ls.text
			o_ls.extend(n_ls.findall('./'))
			o_ls.attrib['enabled'] = enabled

ET.dump(o_xml)


