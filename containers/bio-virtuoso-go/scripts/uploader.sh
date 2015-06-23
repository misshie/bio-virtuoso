#!/bin/bash

url="http://virtuoso-goloso:4567/rdfxml"
graph="http://purl.obolibrary.org/obo/go/go.owl"
file="go.owl"

curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}
echo
