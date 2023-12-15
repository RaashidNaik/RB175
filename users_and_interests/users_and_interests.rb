require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  raw_data = File.read("data/users.yaml")
  @user_data = Psych.load(raw_data)
  @user_names = @user_data.keys
end

helpers do
  def count_interests
    number_of_interests = 0
    @user_names.each do |user_name|
      number_of_interests += @user_data[user_name][:interests].size
    end
    number_of_interests
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  @words = ["blubber", "beluga", "galoshes", "mukluk", "narwhal"]
  erb :home
end

get "/users/:username" do
  @user_name = params[:username]
  @email = @user_data[@user_name.to_sym][:email]
  @interests = @user_data[@user_name.to_sym][:interests]
  erb :users
end
