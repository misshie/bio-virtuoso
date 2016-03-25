module Omim2rdf

  # Convert OMIM offifical tables  to Turtle files
  # require ruby >=2.1.0
  class MorbitMap
    MorbidMap =
      Struct.new(:phenotype,
                 :gene_symbol,
                 :mim_number,
                 :cyto_location)

    attr_reader :path
    def load_opts(opts)
      raise "options --MorbidMap is not given" unless opts["MorbidMap"]
      @path = opts["MorbidMap"]
    end

    def puts_triple(fout, s, p, o)
      fout.puts Triple.triple(s, p, o) unless o.empty?
    end

    def puts_tripleq(fout, s, p, o, xsd="")
      fout.puts Triple.tripleq(s, p, o, xsd) unless o.empty?
    end

    def puts_property_definitions(fout)
      puts_tripleq(fout, "omim:phenotype",     "rdfs:label", "phenotype")
      puts_tripleq(fout, "omim:gene_symbol",   "rdfs:label", "gene symbol")
      puts_tripleq(fout, "omim:mim_number",    "rdfs:label", "MIM number")
      puts_tripleq(fout, "omim:cyto_location", "rdfs:label", "cytogentic location")
    end

    def convert(io)
      fout = io[:fout]
      fin = io[:fin]
      
      Turtle.default_prefix.each {|x|fout.puts x}
      puts_property_definitions(fout)
      
      fin.each_line do |row|
        row.chomp!
        if row.start_with?("# Generated: ")
          gen = "#{row.sub(/\A\# Generated: /,'')}-00-00"
          puts_tripleq(fout, "omim:morbidmap.ttl", "rdfs:label", "generated from OMIM's genemap.txt")
          puts_tripleq(fout, "omim:morbidmap.ttl", "dcterms:issued", gen, "^^xsd:dateTime")
        end
        next if row.start_with?("#")

        uuid = Triple.generate_uuid
        morbidmap = RowMorbidMap.new(row.split("\t"))
        puts_tripleq(fout, uuid, "omim:phenotype",     morbidmap.phenotype)
        morbidmap.gene_symbol.split(", ").each do |o|
          puts_tripleq(fout, uuid, "omim:gene_symbol", o)
        end
        puts_tripleq(fout, uuid, "omim:mim_number",    "rdfs:label", "MIM number")
        puts_tripleq(fout, uuid, "omim:cyto_location", "rdfs:label", "cytogentic location")
      end
    end

    def run(opts)
      load_opts(opts)
      open(path, 'r') do |fin|
        outname = File.basename(path).asub(/\.txt\z/, '.ttl') 
        open(outname, 'w') do |fout|
          convert(fin: fin, fout: fout)
        end
      end
    end
  
  end # class

end # module
