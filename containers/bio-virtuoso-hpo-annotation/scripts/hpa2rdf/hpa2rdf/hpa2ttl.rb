module Hpa2rdf

  # Convert HPO annotation table to Turtle
  # require ruby >=2.1.0
  class Hpa2ttl

    HPA =     
      Struct.new(:db,            # 1required 	OMIM
                 :db_object_id,  # 2 required 	154700
                 :db_name,       # 3 required 	Achondrogenesis, type IB
                 :qualifier,     # 4 optional 	NOT
                 :hpo_id,        # 5 required 	HP:0002487
                 :db_reference,  # 6 required 	OMIM:154700 or PMID:15517394
                 :evidence_code, # 7 required 	IEA
                 :onset,         # 8 modifier	optional	HP:0003577
                 :frequency,     # 9 modifier	optional	"70%" or "12 of 30" or from the vocabulary show in table 2
                 :with, 	 #10 optional 	 
                 :aspect, 	 #11 required 	O
                 :synonym,       #12 optional 	ACG1B|Achondrogenesis, Fraccaro type
                 :date,          #13 required 	YYYY.MM.DD
                 :assigned_by,   #14 required 	HPO
                )
    def puts_schema
      #
    end

    def puts_triples(uuid, hpa)
      Turtle.puts_triple_q(uuid, "rdfs:label",        "#{hpa.db}:#{hpa.db_object_id}")
      Turtle.puts_triple_q(uuid, "hpa:db",            hpa.db)
      # case hpa[:db]
      # when "MIM", "OMIM"
      #   #
      # when "ORPHANET"
      #   #
      # when "DECIPHER"
      #   #
      # end
      Turtle.puts_triple(uuid, "hpa:db_object_id",  hpa.db_object_id)
      Turtle.puts_triple_q(uuid, "hpa:db_name",       hpa.db_name, "@en")
      Turtle.puts_triple_q(uuid, "hpa:qualifier",     hpa.qualifier)
      Turtle.puts_triple(uuid, "hpa:hpo_id",        "obo:HP_#{hpa.hpo_id.split(':')[1]}")
      Turtle.puts_triple_q(uuid, "hpa:db_reference",  hpa.db_reference)
      Turtle.puts_triple_q(uuid, "hpa:evidence_code", hpa.evidence_code)
      Turtle.puts_triple_q(uuid, "hpa:onset",         hpa.onset)
      Turtle.puts_triple_q(uuid, "hpa:frequency",     hpa.frequency)
      Turtle.puts_triple_q(uuid, "hpa:with",          hpa.with)
      Turtle.puts_triple_q(uuid, "hpa:aspect",        hpa.aspect)
      Turtle.puts_triple_q(uuid, "hpa:synomym",       hpa.synonym)
      Turtle.puts_triple_q(uuid, "hpa:date",          hpa.date)
      Turtle.puts_triple_q(uuid, "hpa:assigned_by",   hpa.assigned_by)
    end                         

    def run
      Turtle.default_prefix.each{|x| puts x}
      Turtle.property_definitions.each{|x| puts x}
      puts
      puts_schema
      ARGF.each_line do |row|
        row.chomp!
        next if row.start_with? '#'
        puts_triples(Turtle.new_uuid, HPA.new(*(row.scrub.split("\t"))))
        puts
      end
    end
  
  end # class

end # module
