#!/bin/bash
curl \
    http://download.bio2rdf.org/release/3/hgnc/hgnc_complete_set.nq.gz \
    -o hgnc_complete_set.nq.gz

curl \
    http://download.bio2rdf.org/release/3/hgnc/hgnc.schema.owl \
    -o hgnc.schema.owl
