module Omim2rdf

  # Convert OMIM offifical tables  to Turtle files
  # require ruby >=2.1.0
  class GeneMap2
    RowGeneMap2 =
      Struct.new(:chromosome,
                 :genomic_position_start, :genomic_position_end,
                 :cyto_location,
                 :computed_cyto_location,
                 :mim_number,
                 :gene_symbol,
                 :gene_name,
                 :approved_symbol,
                 :entrez_gene_id,
                 :ensembl_gene_id,
                 :comments,
                 :phenotypes,
                 :mouse_gene_symbol_id)

    attr_reader :path
    def load_opts(opts)
      raise "options --GeneMap is not given" unless opts["GeneMap"]
      @path = opts["GeneMap"]
    end

    def puts_triple(fout, s, p, o)
      fout.puts Triple.triple(s, p, o) unless o.empty?
    end

    def puts_tripleq(fout, s, p, o, xsd="")
      fout.puts Triple.tripleq(s, p, o, xsd) unless o.empty?
    end

    def puts_property_definitions(fout)
      puts_tripleq(fout, "omim:chromosome",             "rdfs:label", "chromosome")
      puts_tripleq(fout, "omim:genomic_position_start", "rdfs:label", "genomic position start")
      puts_tripleq(fout, "omim:genomic_position_end",   "rdfs:label", "genomic position end")
      puts_tripleq(fout, "omim:cyto_location",          "rdfs:label", "cytogenetic location")
      puts_tripleq(fout, "omim:computed_cyto_location", "rdfs:label", "computed cytogenetic location")
      puts_tripleq(fout, "omim:mim_number",             "rdfs:label", "MIM number")
      puts_tripleq(fout, "omim:gene_symbol",            "rdfs:label", "gene symbol")
      puts_tripleq(fout, "omim:gene_name",              "rdfs:label", "gene name")
      puts_tripleq(fout, "omim:approved_symbol",        "rdfs:label", "approved symbol")
      puts_tripleq(fout, "omim:entrez_gene_id",         "rdfs:label", "Entrez gene ID")
      puts_tripleq(fout, "omim:ensembl_gene_id",        "rdfs:label", "Ensembl gene ID")
      puts_tripleq(fout, "omim:comments",               "rdfs:label", "comment")
      puts_tripleq(fout, "omim:phenotype",              "rdfs:label", "phenotype")
      puts_tripleq(fout, "omim:mouse_gene_symbol_id",   "rdfs:label", "mouse gene symbol/ID")
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

        uuid = Triple.generate_uuid
        genemap2 = RowGeneMap2.new(row.split("\t"))
        puts_tripleq(fout, uuid, "omim:chromosome", genemap2.chromosome)
        puts_tripleq(fout, uuid, "omim:genomic_position_start", genemap2.genomic_position_start)
        puts_tripleq(fout, uuid, "omim:genomic_position_end",   genemap2.genomic_position_end)
        puts_tripleq(fout, uuid, "omim:cyto_location",          genemap2.cyto_location)
        puts_tripleq(fout, uuid, "omim:computed_cyto_location", genemap2.computed_cyto_location)
        puts_tripleq(fout, uuid, "omim:mim_number",             genemap2.mim_number)
        genemap2.mim_number.split(", ").each do |o|
          puts_tripleq(fout, uuid, "omim:gene_symbol", o)
        end
        puts_tripleq(fout, uuid, "omim:gene_name",              genemap2.gene_name)
        puts_tripleq(fout, uuid, "omim:approved_symbol",        genemap2.approved_symbol)
        puts_tripleq(fout, uuid, "omim:entrez_gene_id",         genemap2.entrez_gene_id)
        puts_tripleq(fout, uuid, "omim:ensemble_gene_id",       genemap2.ensembl_gene_id)
        puts_tripleq(fout, uuid, "omim:phenotype",              genemap2.ensembl_phenotype)
        puts_tripleq(fout, uuid, "omim:mouse_gene_symbol_id",   genemap2.mouse_gene_symbol_id)
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
