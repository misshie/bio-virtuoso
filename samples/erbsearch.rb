#!/usr/bin/env ruby

require 'fileutils'
require 'erubis'
require 'tempfile'
require 'optparse'

URL = "http://localhost:8890/sparql"
FORMAT = "text/tab-separated-values"
DEFAULTQ = "default.sparql.erb"
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

  def search_word(qfile, word)
    sparql = Erubis::Eruby.new(File.read(qfile))
    submit_query sparql.result(word: word)
  end

  def run
    query = OptionParser.getopts("q:")
    qfile = query["q"]
    qfile ||= DEFAULTQ
    ARGF.each_line do |row|
      puts search_word(qfile, row.chomp)
    end
  end
end

if $0 == __FILE__
  SqSearch.new.run
end
