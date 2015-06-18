#!/usr/bin/env ruby
#

require 'sinatra'
require 'haml'

#ISQL = "/usr/local/bin/virtuoso"
ISQL = "wc"

set :public_dir, File.dirname(__FILE__) + '/public'

##########
get '/' do
  haml :index
end

#################
post '/turtle' do
  halt 400, "400 BAD REQUEST" unless (params[:file] && params[:graph])
  begin
    filepath = "./public/#{params[:file][:filename]}"
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
    filepath = "./public/#{params[:file][:filename]}"
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
