#!/usr/bin/env ruby
require 'fileutils'
require 'erubis'
require 'tempfile'

URL = "http://localhost:8890/sparql"
FORMAT = "text/tab-separated-values"
QUERY1 = "query1.sparql.erb"
TEMP = "__TEMP__.txt"

class SqSearch
  def submit_query(sparql)
    results = ""
    Tempfile.open(TEMP) do |ftmp|
      sparql.each_line{|x| ftmp.puts x}
      ftmp.close
      ftmp.open
      results = %x!curl -s --form "format=#{FORMAT}" --form "query=@#{ftmp.path}" #{URL}! 
      ftmp.close!
    end
    results
  end

  def search_word(word)
    sparql = Erubis::Eruby.new(File.read(QUERY1))
    submit_query sparql.result(word: word)
  end

  def run
    ARGF.each_line do |row|
      row.chomp!
      next if row.start_with? '#'
      next if row.empty?
      puts search_word(row)
    end
  end
end

if $0 == __FILE__
  SqSearch.new.run
end
