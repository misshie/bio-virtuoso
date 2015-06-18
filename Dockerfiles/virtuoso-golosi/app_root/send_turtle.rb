#!/usr/bin/env ruby

URL = "http://localhost:4567/turtle"
GRAPH = "http://misshie.jp/rdf/test-turtle"
FILE = "turtle.ttl"

system(["curl",
	"-X POST",
	"-F graph=#{GRAPH}",
	"-F file=@#{FILE}",
	URL,
	].join(' '))
puts
