#!/bin/bash

url="http://localhost:8890/sparql"
graph="http://misshie.jp/rdf/test-rdfxml"
#format="text/turtle"
format="text/tab-separated-values"

echo ">>> Test HPO"
query=`cat <<EOF
SELECT "*"
FROM <http://purl.obolibrary.org/obo/hp.owl> 
WHERE { ?s ?p ?o . }
LIMIT 10
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}

echo ">>> TEST GO"
query=`cat <<EOF
SELECT "*"
FROM <http://purl.obolibrary.org/obo/go/go.owl> 
WHERE { ?s ?p ?o . }
LIMIT 10
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
