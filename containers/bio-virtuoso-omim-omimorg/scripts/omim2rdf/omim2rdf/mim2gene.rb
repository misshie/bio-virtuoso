module Omim2rdf

  # Convert OMIM offifical tables  to Turtle files
  # require ruby >=2.1.0
  class Mim2Gene
    RowMim2Gene =
      Struct.new(:mim_number,
                 :mim_entry_type,
                 :entrez_gene_id,
                 :approved_gene_symbol,
                 :ensembl_gene_id)
    
    attr_reader :path
    def load_opts(opts)
      raise "options --Mim2Gene is not given" unless opts["Mim2Gene"]
      @path = opts["Mim2Gene"]
    end

    def puts_triple(fout, s, p, o)
      fout.puts Triple.triple(s, p, o) unless o.empty?
    end
  
    def puts_tripleq(fout, s, p, o, xsd="")
      fout.puts Triple.tripleq(s, p, o, xsd) unless o.empty?
    end

    def puts_property_definitions(fout)
       puts_tripleq(fout, "omim:mim_number",           "rdfs:label", "OMIM ID")
       puts_tripleq(fout, "omim:mim_entry_type",       "rdfs:label", "OMIM entry type")
       puts_tripleq(fout, "omim:entrez_gene_id",       "rdfs:label", "Entres gene ID")
       puts_tripleq(fout, "omim:approved_gene_symbol", "rdfs:label", "HGNC gene symbol")
       puts_tripleq(fout, "omim:ensemble_gene_id",     "rdfs:label", "Ensemble gene ID")
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
          puts_tripleq(fout, "omim:mim2gene.ttl", "rdfs:label", "generated from OMIM's mim2gene.txt")
          puts_tripleq(fout, "omim:mim2gene.ttl", "dcterms:issued", gen, "^^xsd:dateTime")
        end
        next if row.start_with?("#")

        uuid = Triple.generate_uuid
        mim2gene = RowMim2Gene.new(*row.split("/t"))
        puts_tripleq(fout, uuid, "omim:mim_number", mim2gene.mim_number)
        puts_tripleq(fout, uuid, "omim:mim_entry_type", mim2gene.mim_entry_type) 
        puts_tripleq(fout, uuid, "omim:entrez_gene_id", mim2gene.entrez_gene_id) 
        puts_tripleq(fout, uuid, "omim:approved_gene_symbol", mim2gene.approved_gene_symbol)
        puts_tripleq(fout, uuid, "omim:ensemble_gene_id", mim2gene.ensemble_gene_id)
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
    end

  end # class

end # module
