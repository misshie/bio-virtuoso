#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"
file="omim2ja.ttl"
graph="http://misshie.jp/rdf/omim2ja.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo
