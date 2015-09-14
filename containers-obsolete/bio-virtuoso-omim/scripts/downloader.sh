#!/bin/bash
curl \
    http://download.bio2rdf.org/release/3/omim/omim.nq.gz \
    -o omim.nq.gz

curl \
    http://download.bio2rdf.org/release/3/omim/omim.schema.owl \
    -o omim.schema.owl
