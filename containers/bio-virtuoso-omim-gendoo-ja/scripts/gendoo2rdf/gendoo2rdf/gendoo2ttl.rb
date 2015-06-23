module Gendoo2rdf

  # Convert HPO annotation table to Turtle
  # require ruby >=2.1.0
  class Gendoo2ttl

    OMIM2JA =     
      Struct.new(:omim, :text)

    def puts_schema
      #
    end

    def puts_triples(uuid, omim2ja)
      unless omim2ja.text == "-"
        Turtle.puts_triple_q(uuid, "hpa:db", "OMIM")
        Turtle.puts_triple(uuid, "hpa:db_object_id", omim2ja.omim)
        Turtle.puts_triple_q(uuid, "hpa:db_name", omim2ja.text, "@ja")
        puts
      end
    end                         

    def run
      Turtle.default_prefix.each{|x| puts x}
      puts
      puts_schema
      ARGF.each_line do |row|
        row.chomp!
        next if row.start_with? '#'
        puts_triples(Turtle.new_uuid, OMIM2JA.new(*(row.scrub.split("\t"))))
      end
    end
  
  end # class

end # module
