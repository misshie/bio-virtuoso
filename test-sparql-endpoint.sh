#!/bin/bash
#
# when you use * in query, use it with double quartations ("*").

url="http://localhost:8890/sparql"
graph="http://misshie.jp/rdf/test-rdfxml"
#format="text/turtle"
format="text/tab-separated-values"

echo ">>> Test HPO"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://purl.obolibrary.org/obo/hp.owl> 
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> TEST GO"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://purl.obolibrary.org/obo/go/go.owl> 
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> Test HPO Annotation"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://misshie.jp/rdf/phenotype_annotation.ttl> 
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> Test HPO Annotation (HPO team)"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://misshie.jp/rdf/phenotype_annotation_hpoteam.ttl> 
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> Test HPO Annotation (negative annotation)"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://misshie.jp/rdf/negative_phenotype_annotation.ttl>
WHERE { ?s ?property ?o . }
LIMIT 20
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> Test HPO Annotation (negative annotation)"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://misshie.jp/rdf/negative_phenotype_annotation.ttl>
WHERE { ?s ?property ?o . }
LIMIT 10
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo

echo ">>> Test OMIM entry Japanese translation by Gendoo"
query=`cat <<EOF
SELECT DISTINCT ?property
FROM <http://misshie.jp/rdf/omim2ja.ttl>
WHERE { ?s ?property ?o . }
LIMIT 10
EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo
