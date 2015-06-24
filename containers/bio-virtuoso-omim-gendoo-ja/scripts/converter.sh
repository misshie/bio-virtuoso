#!/bin/bash

echo ">>> Convert Gendoo's OMIM Japanese translation data to Turtle"
/usr/local/bin/ruby gendoo2rdf/gendoo2rdf.rb omim2ja.tab > omim2ja.ttl
