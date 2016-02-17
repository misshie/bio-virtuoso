#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/hpoa_dataset.ttl"
file="hpoa_dataset.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/hpoa.ttl"
file="hpoa.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo
