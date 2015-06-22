require_relative "hpa2rdf/turtle"
require_relative "hpa2rdf/hpa2ttl"
require_relative "hpa2rdf/version"

if $0 == __FILE__
  Hpa2rdf::Hpa2ttl.new.run
end
