module Omim2rdf

  # Convert OMIM offifical tables  to Turtle files
  # require ruby >=2.1.0
  class GeneMap
    RowGeneMap =
      Struct.new(:colsort, :colmonth, :colday, :colyear,
                 :cyto_location,
                 :gene_symbol,
                 :confidence,
                 :gene_name,
                 :mim_number,
                 :mapping_method,
                 :comment,
                 :phenotype,
                 :mouse_gene_symbol)
    
    attr_reader :path
    def load_opts(opts)
      raise "options --GeneMap is not given" unless opts["GeneMap"]
      @path = opts["GeneMap"]
    end

    def puts_triple(fout, s, p, o)
      fout.puts Turtle.triple(s, p, o) if !(o.nil? || o.empty?)
    end

    def puts_tripleq(fout, s, p, o, xsd="")
      fout.puts Turtle.tripleq(s, p, o, xsd) if !(o.nil? || o.empty?)
    end

    def puts_property_definitions(fout)
      puts_tripleq(fout, "omim:sort",              "rdfs:label", "sort order")
      puts_tripleq(fout, "omim:month",             "rdfs:label", "update month in two digits")
      puts_tripleq(fout, "omim:day",               "rdfs:label", "update day in two digits")
      puts_tripleq(fout, "omim:year",              "rdfs:label", "update year in two digits")
      puts_tripleq(fout, "omim:cyto_Location",     "rdfs:label", "cytogenetic location")
      puts_tripleq(fout, "omim:gene_symbol",       "rdfs:label", "gene symbol")
      puts_tripleq(fout, "omim:confidence",        "rdfs:label", "confidence")
      puts_tripleq(fout, "omim:gene_name",         "rdfs:label", "gene name")
      puts_tripleq(fout, "omim:mim_number",        "rdfs:label", "MIM number")
      puts_tripleq(fout, "omim:mapping_method",    "rdfs:label", "mapping method")
      puts_tripleq(fout, "omim:comment",          "rdfs:label", "comment")
      puts_tripleq(fout, "omim:phenotype",         "rdfs:label", "phenotype")
      puts_tripleq(fout, "omim:mouse_gene_symbol", "rdfs:label", "mouse_gene_stymbol")
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
          puts_tripleq(fout, "omim:genemap.ttl", "rdfs:label", "generated from OMIM's genemap.txt")
          puts_tripleq(fout, "omim:genemap.ttl", "dcterms:issued", gen, "^^xsd:dateTime")
        end
        next if row.start_with?("#")

        uuid = Turtle.generate_uuid
        genemap = RowGeneMap.new(*row.split("\t"))
        puts_tripleq(fout, uuid, "omim:sort",              genemap.colsort)
        puts_tripleq(fout, uuid, "omim:month",             genemap.colmonth)
        puts_tripleq(fout, uuid, "omim:day",               genemap.colday)
        puts_tripleq(fout, uuid, "omim:year",              genemap.colyear)
        puts_tripleq(fout, uuid, "omim:cyto_Location",     genemap.cyto_location)
        if genemap.gene_symbol
          genemap.gene_symbol.split(",").each do |o|
            puts_tripleq(fout, uuid, "omim:gene_symbol", o)
          end
        end
        puts_tripleq(fout, uuid, "omim:confidence",        genemap.confidence)
        puts_tripleq(fout, uuid, "omim:gene_name",         genemap.gene_name)
        puts_tripleq(fout, uuid, "omim:mim_number",        genemap.mim_number)
        if genemap.mapping_method
          genemap.mapping_method.split(", ").each do |o|
            puts_tripleq(fout, uuid, "omim:mapping_method", o)
          end
        end
        puts_tripleq(fout, uuid, "omim:comment",           genemap.comment)
        puts_tripleq(fout, uuid, "omim:phenotype",         genemap.phenotype)
        puts_tripleq(fout, uuid, "omim:mouse_gene_symbol", genemap.mouse_gene_symbol)
      end
    end

    def run(opts)
      load_opts(opts)
      open(path, 'r') do |fin|
        outname = File.basename(path).sub(/\.txt\z/, '.ttl') 
        open(outname, 'w') do |fout|
          convert(fin: fin, fout: fout)
        end
      end
    end
  
  end # class

end # module
