#!/usr/local/bin/ruby

require 'sinatra'
require 'haml'
require 'tilt/haml'

VIRTUOSO = "/usr/local/virtuoso-opensource"
PUBLIC   = "#{VIRTUOSO}/var/lib/virtuoso/db"
SQLFILE  = "#{PUBLIC}/sqlfile.sql"
ISQL     = "#{VIRTUOSO}/bin/isql localhost:1111 dba dba errors=stdout #{SQLFILE}"
DEFAULTIRI = "http://misshie.jp/rdf/default"
FLAG = 512 + 32 # N-quad + Allows invalid symbols between '<' and '>' 

MaxQueryCostEstimationTime = ENV['MaxQueryCostEstimationTime']
MaxQueryExecutionTime = ENV['MaxQueryExecutionTime']
MaxQueryExecutionTime ||= "21600" # 6hrs
NumberOfBuffers = ENV['NumberOfBuffers']
NumberOfBuffers ||= '85000' # 4000000 for 48Gb RAM
MaxDirtyBuffers = ENV['MaxDirtyBuffers']
MaxDirtyBuffers ||= '65000' # 3000000 for 48Gb RAM
SQL_PREFETCH_ROWS = ENV['SQL_PREFETCH_ROWS']
SQL_PREFETCH_ROWS ||= '10000'
SQL_PREFETCH_BYTES = ENV['SQL_PREFETCH_BYTES']
SQL_PREFETCH_BYTES ||= '160000'

set :environment, :production
set :public_dir, PUBLIC

puts "== invoke Virtuoso on port 8890"
print "step1: "
puts system("chown -R `whoami` db", chdir: "#{VIRTUOSO}/var/lib/virtuoso")

print "step2: "
puts system("mv virtuoso.ini virtuoso.ini.orig", chdir: PUBLIC)
open("#{PUBLIC}/virtuoso.ini", 'w') do |fout|
  open("#{PUBLIC}/virtuoso.ini.orig",'r') do |fin|
    fin.each_line do |row|
      row.chomp
      case row
      when /\AMaxQueryCostEstimationTime/, /\AMaxQueryExecutionTime/
        next
      else
        fout.puts row
      end
    end
  end
  fout.puts "MaxQueryCostEstimationTime = #{MaxQueryCostEstimationTime}" if MaxQueryCostEstimationTime
  fout.puts "MaxQueryExecutionTime = #{MaxQueryExecutionTime}" 
  fout.puts "NumberOfBuffers = #{NumberOfBuffers}"
  fout.puts "MaxDirtyBuffers = #{MaxDirtyBuffers}"
end
puts "done"

print "step3: "
puts system("#{VIRTUOSO}/bin/virtuoso-t", chdir: PUBLIC)
puts

##########
get '/' do
  haml :index
end

#################
post '/turtle' do
  puts "== app.rb #{Time.now}"
  halt 400, "400 BAD REQUEST" unless (params[:file] && params[:graph])
  begin
    filepath = "#{PUBLIC}/#{params[:file][:filename]}"
    fout = File.open(filepath, 'wb')
    puts "post: #{filepath}"
    puts "graph: #{params[:graph]}"
    fout.write params[:file][:tempfile].read
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    fout.close
  end

  open(SQLFILE, 'w') do |fout|
    fout.puts "log_enable(2,1);"
    fout.puts "DB.DBA.TTLP_MT(file_to_string_output('#{filepath}'),'','#{params[:graph]}');"
    fout.puts "EXIT;"
  end
  puts "Built SQL:"
  File.readlines(SQLFILE).each{|x| puts x}
  puts "isql: "
  puts `#{ISQL}`
  ($?.exitstatus == 0) ? (halt 200, "200 OK") : (halt 500, "500 INTERNAL SERVER ERROR")
end

#################
post '/rdfxml' do
  puts "== app.rb #{Time.now}"
  halt 400, "400 BAD REQUEST" unless (params[:file] && params[:graph])
  begin
    filepath = "#{PUBLIC}/#{params[:file][:filename]}"
    fout = File.open(filepath, 'wb')
    puts "post: #{filepath}"
    puts "graph: #{params[:graph]}"
    fout.write params[:file][:tempfile].read
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    fout.close
  end
  
  open(SQLFILE, 'w') do |fout|
    fout.puts "log_enable(2,1);"
    fout.puts "DB.DBA.RDF_LOAD_RDFXML_MT(file_to_string_output('#{filepath}'),'','#{params[:graph]}');"
    fout.puts "EXIT;"
  end
  puts "Built SQL:"
  File.readlines(SQLFILE).each{|x| puts x}
  puts "isql: "
  puts `#{ISQL}`
  ($?.exitstatus == 0) ? (halt 200, "200 OK") : (halt 500, "500 INTERNAL SERVER ERROR")
end

#################
post '/n-quad' do
  puts "== app.rb #{Time.now}"
  halt 400, "400 BAD REQUEST" unless (params[:file])
  begin
    filepath = "#{PUBLIC}/#{params[:file][:filename]}"
    fout = File.open(filepath, 'wb')
    puts "post: #{filepath}"
    puts "graph: ignored for N-Quads"
    fout.write params[:file][:tempfile].read
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    fout.close
  end
  
  open(SQLFILE, 'w') do |fout|
    fout.puts "log_enable(2,1);"
    fout.puts "DB.DBA.TTLP_MT(file_to_string_output('#{filepath}'),'','#{DEFAULTIRI}',#{FLAG});"
    fout.puts "EXIT;"
  end
  puts "Built SQL:"
  File.readlines(SQLFILE).each{|x| puts x}
  puts "isql: "
  puts `#{ISQL}`
  ($?.exitstatus == 0) ? (halt 200, "200 OK") : (halt 500, "500 INTERNAL SERVER ERROR")
end
