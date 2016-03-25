require 'optparse'
require_relative "omim2rdf/turtle"
require_relative "omim2rdf/version"
require_relative "omim2rdf/omim2ttl"
require_relative "omim2rdf/mim2gene"
require_relative "omim2rdf/mimtitles"
require_relative "omim2rdf/genemap"
require_relative "omim2rdf/morbidmap"
require_relative "omim2rdf/genemap2"

if $0 == __FILE__
  opts =
    ARGV.getopts('', 'Mim2Gene:', 'MimTitles:', 'GeneMap:', 'MorbidMap:', 'GeneMap2:')
  Omim2rdf::Omim2ttl.new.run(opts)
end
