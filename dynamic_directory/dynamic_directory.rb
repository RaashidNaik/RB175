require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @file_list = Dir.glob("public/*").map {|file| File.basename(file) }.sort
  @file_list.reverse! if params[:sort] == "desc"
  erb :home
end