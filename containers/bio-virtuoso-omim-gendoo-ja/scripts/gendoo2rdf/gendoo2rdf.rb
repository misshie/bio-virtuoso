require_relative "gendoo2rdf/turtle"
require_relative "gendoo2rdf/gendoo2ttl"
require_relative "gendoo2rdf/version"

if $0 == __FILE__
  Gendoo2rdf::Gendoo2ttl.new.run
end
