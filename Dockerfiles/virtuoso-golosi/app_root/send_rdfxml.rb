#!/usr/bin/env ruby

URL = "http://localhost:4567/rdfxml"
GRAPH = "http://misshie.jp/rdf/test-rdfxml"
FILE = "rdfxml.rdf"

system(["curl",
	"-X POST",
	"-F graph=#{GRAPH}",
	"-F file=@#{FILE}",
	URL,
	].join(' '))
puts
