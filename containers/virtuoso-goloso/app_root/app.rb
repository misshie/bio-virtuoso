#!/usr/local/bin/ruby

require 'sinatra'
require 'haml'

VIRTUOSO = "/usr/local/virtuoso-opensource"
ISQL     = "#{VIRTUOSO}/bin/isql"
PUBLIC   = "#{VIRTUOSO}/var/lib/virtuoso/db"

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
  halt 400, "400 BAD REQUEST" unless (params[:file] && params[:graph])
  begin
    filepath = "#{PUBLIC}/#{params[:file][:filename]}"
    fout = File.open(filepath, 'wb')
    p filepath
    p params[:graph]
    fout.write params[:file][:tempfile].read
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    fout.close
  end

  sql = <<-"SQL"
log_enable(2,1);
DB.DBA.TTLP_MT(file_to_string_output('#{filepath}'),'','#{params[:graph]}');
EXIT;
  SQL

  begin
    pipe = IO.popen(ISQL, 'w+')
    pipe.puts sql
    pipe.close_write
    p pipe.gets
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    pipe.close
  end
  halt 200, "200 OK"
end

#################
post '/rdfxml' do
  halt 400, "400 BAD REQUEST" unless (params[:file] && params[:graph])
  begin
    filepath = "#{PUBLIC}/#{params[:file][:filename]}"
    fout = File.open(filepath, 'wb')
    p filepath
    p params[:graph]
    fout.write params[:file][:tempfile].read
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR"
  ensure
    fout.close
  end
  
  sql = <<-"SQL"
log_enable(2,1);
DB.DBA.RDF_LOAD_RDFXML_MT(file_to_string_output(#{filepath}'),'','#{params[:graph]}');
EXIT;
  SQL
  begin
    pipe = IO.popen(ISQL, 'w+')
    pipe.puts sql
    pipe.close_write
    p pipe.gets
  rescue IOError, SystemCallError
    halt 500, "500 INTERNAL SERVER ERROR #{$!}"
  ensure
    pipe.close
  end
  halt 200, "200 OK"
end
