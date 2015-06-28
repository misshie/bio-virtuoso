#!/bin/bash
#
# when you use * in query, use it with double quartations ("*").

url="http://localhost:8890/sparql"
#format="text/turtle"
format="text/tab-separated-values"

query=`cat <<EOF
SELECT DISTINCT ?p, ?g
WHERE
{
  { ?s ?p ?o . }
UNION
  { GRAPH ?g {?s ?p ?o . } }
}
ORDER BY ?p

EOF
`
eval curl --form "\"format="${format}"\"" --form "\"query="${query}"\"" ${url}
echo
