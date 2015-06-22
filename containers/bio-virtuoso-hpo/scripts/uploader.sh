#!/bin/bash

url="http://virtuoso-goloso:4567/rdfxml"
graph="http://purl.obolibrary.org/obo/hp.owl"
file="hp.owl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}

