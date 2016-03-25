module Omim2rdf

  # Convert OMIM offifical tables  to Turtle files
  # require ruby >=2.1.0
  class MimTitles
    RowMimTitles =
      Struct.new(:prefix,
                 :mim_number,
                 :preferred_title,          # semicolon-separated
                 :symbol_alternative_title, # semicolon-separated
                 :included_title,           # semicolon-separated
                 :symbol)                   # semicolon-separated

    attr_reader :path
    def load_opts(opts)
      raise "options --MimTitles is not given" unless opts["MimTitles"]
      @path = opts["MimTitles"]
    end

    def puts_triple(fout, s, p, o)
      fout.puts Triple.triple(s, p, o) unless o.empty?
    end
  
    def puts_tripleq(fout, s, p, o, xsd="")
      fout.puts Triple.tripleq(s, p, o, xsd) unless o.empty?
    end

    def puts_property_definitions(fout)
      puts_tripleq(fout, "omim:prefix", "rdfs:label",
                   "Asterisk(*), Plus(+), Number Sign(#), Percent(%), Caret(^), or NULL")
      puts_tripleq(fout, "omim:mim_number",               "rdfs:label", "OMIM ID")
      puts_tripleq(fout, "omim:preferred_title",          "rdfs:label", "OMIM preferred title")
      puts_tripleq(fout, "omim:alternative_title",        "rdfs:label", "alternative title")
      puts_tripleq(fout, "omim:included_title",           "rdfs:label", "included title")
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
          puts_tripleq(fout, "omim:mimtitles.ttl", "rdfs:label", "generated from OMIM's mimTitles.txt")
          puts_tripleq(fout, "omim:mimtitles.ttl", "dcterms:issued", gen, "^^xsd:dateTime")
        end
        next if row.start_with?("#")

        uuid = Triple.generate_uuid
        mimtitles = RowMimTitles.new(row.split("\t"))
        puts_tripleq(fout, uuid, "omim:prefix",  mimtitles.prefix)
        puts_tripleq(fout, uuid, "omim:mim_number", mimtitles.mim_number)
        mimtiles.preferred_titile).split(";; ").each do |o|
          puts_tripleq(fout, uuid, "omim:preferred_title", o)
        end
        mimtitles.sybmol_alternative_title).split(";; ").each do |o|
          puts_tripleq(fout, uuid, "omim:symbol_alternative_title", o)
        end
        mimtiles.included_title.split(";; ").each do |o|
          puts_tripleq(fout, uuid, "omim:included_title", o)
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
      
    end
  
  end # class

end # module
