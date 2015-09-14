#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/orphanet_dataset.ttl"
file="orphanet_dataset.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

url="http://virtuoso-goloso:4567/turtle"
graph="http://data.monarchinitiative.org/ttl/orphanet.ttl
file="orphanet.ttl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo

