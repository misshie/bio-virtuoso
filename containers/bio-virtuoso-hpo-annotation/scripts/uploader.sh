#!/bin/bash

url="http://virtuoso-goloso:4567/turtle"

file="phenotype_annotation_hpoteam.ttl"
graph="http://misshie.jp/rdf/phenotype_annotation_hpoteam.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}

file="phenotype_annotation.ttl"
graph="http://misshie.jp/rdf/phenotype_annotation.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}

file="negative_phenotype_annotation.ttl"
graph="http://misshie.jp/rdf/negative_phenotype_annotation.ttl"
curl \
     -X POST \
     -F graph=${graph} \
     -F file=@${file} \
     ${url}

