#!/bin/bash
set -eu

echo ">>> Convert OMIM official tables to Turtle files"
scr=omim2rdf/omim2rdf.rb
dldir=/opt/bio-virtuoso/omim-omimorg/downloads
ruby ${scr} \
     --Mim2Gene ${dldir}/mim2gene.txt \
     --MimTitles ${dldir}/mimTitles.txt \
     --GeneMap ${dldir}/genemap.txt \
     --MorbidMap ${dldir}/morbidmap.txt \
     --GeneMap2 ${dldir}/genemap2.txt
echo

url="http://virtuoso-goloso:4567/turtle"

echo ">>> upload mim2gene.ttl"
file="mim2gene.ttl"
graph="http://misshie.jp/rdf/omim/${file}"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

echo ">>> upload mimTitles.ttl"
file="mimTitles.ttl"
graph="http://misshie.jp/rdf/omim/${file}"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

echo ">>> upload genemap.ttl"
file="genemap.ttl"
graph="http://misshie.jp/rdf/omim/${file}"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

echo ">>> upload morbidmap.ttl"
file="morbidmap.ttl"
graph="http://misshie.jp/rdf/omim/${file}"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

echo ">>> upload genemap2.ttl"
file="genemap2.ttl"
graph="http://misshie.jp/rdf/omim/${file}"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo
