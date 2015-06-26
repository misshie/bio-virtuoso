#!/usr/local/bin/ruby

require 'sinatra'
require 'haml'
require 'tilt/haml'

VIRTUOSO = "/usr/local/virtuoso-opensource"
PUBLIC   = "#{VIRTUOSO}/var/lib/virtuoso/db"
SQLFILE  = "#{PUBLIC}/sqlfile.sql"
ISQL     = "#{VIRTUOSO}/bin/isql localhost:1111 dba dba errors=stdout #{SQLFILE}"

set :environment, :production
set :public_dir, PUBLIC

puts "== invoke Virtuoso on port 8890"
print "step1: "
puts system("chown -R `whoami` db", chdir: "#{VIRTUOSO}/var/lib/virtuoso")
print "step2: "
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
    fout.puts "DB.DBA.TTLP_MT(file_to_string_output('#{filepath}'),'','',512);"
    fout.puts "EXIT;"
  end
  puts "Built SQL:"
  File.readlines(SQLFILE).each{|x| puts x}
  puts "isql: "
  puts `#{ISQL}`
  ($?.exitstatus == 0) ? (halt 200, "200 OK") : (halt 500, "500 INTERNAL SERVER ERROR")
end



