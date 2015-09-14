#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/hgnc_dataset.ttl"
file="hgnc_dataset.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/hgnc.ttl
file="hgnc.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

