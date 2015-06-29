#!/bin/bash
#
# when you use * in query, use it with double quartations ("*").

url="http://localhost:8890/sparql"
#format="text/turtle"
format="text/tab-separated-values"

query=`cat <<EOF
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?p, ?g, ?cmt
WHERE
{
  { ?s ?p ?o .
    OPTIONAL {?p rdfs:label ?cmt .} }
UNION
  { GRAPH ?g {?s ?p ?o . 
              OPTIONAL { ?p rdfs:label ?cmt . } }
  }
}
ORDER BY ?p

EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo
