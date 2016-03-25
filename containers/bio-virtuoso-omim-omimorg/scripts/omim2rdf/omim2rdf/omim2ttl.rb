module Omim2rdf

  # Convert OMIM offifical tables to Turtle files
  class Omnim2ttl
    def run(opts)
      load_opts(opts)
      Mim2Gene.new.run(opts)
      MimTitles.new.run(opts)
      GeneMap.new.run(opts)
      MorbidMap.new.run(opts)
      GeneMap2.new.run(opts)
    end
  end # class

end # module
