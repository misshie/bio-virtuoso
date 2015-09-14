#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/omim_dataset.ttl"
file="omim_dataset.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/omim.ttl
file="omim.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

