module Omim2rdf

  # Convert OMIM offifical tables to Turtle files
  class Omim2ttl

    def run(opts)
      Mim2Gene.new.run(opts)
      MimTitles.new.run(opts)
      GeneMap.new.run(opts)
      MorbidMap.new.run(opts)
      GeneMap2.new.run(opts)
    end

  end # class

end # module
