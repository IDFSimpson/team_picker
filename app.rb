require "sinatra"
require "sinatra/reloader"
require "pry"

enable :sessions

get "/team_picker" do
  binding.pry
  erb :team_picker
end

post "/team_picker" do
  names = params[:names]
  team_count = params[:team_count]
  per_team = params[:per_team]
  number = params[:number]
  session[:name_array] = names.split(",")
  redirect back
end
