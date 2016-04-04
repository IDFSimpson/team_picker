require "sinatra"
require "sinatra/reloader"
require "pry"

enable :sessions

get "/team_picker" do
  erb :team_picker
end

post "/team_picker" do
  names = params[:names]
  number = params[:number].to_i
  session[:name_array] = names.split(",")
  if params[:method] == "team_count"
    # binding.pry
    session[:teams_output] = order_by_team_count(session[:name_array], number)
  # default to per_team as per spec
  else params[:method] == "per_team"
    session[:teams_output] = order_per_team(session[:name_array], number)
  end
  redirect back
end

# Funciton can give unsesired result when number of teams doen't devide niecly. i.e. a,b,c,d. Maybe check with a mod?
def order_per_team(input_array, per_team)
  array = input_array.dup
  output = []
  while array.length > 0 do
    output << (0...per_team).map { array.delete_at(rand(array.length)) if array.length > 0}
  end
  output
end

def order_by_team_count(input_array, team_count)
  array = input_array.dup
  # creates team_count even teams
  output = (0...team_count).map do
    (0...(array.length / team_count)).map { array.delete_at(rand(array.length)) }
  end
  binding.pry
  # adds in any leftovers
  (0...(array.length % team_count)).each { |index| output[index] << array.delete_at(rand(array.length)) }
  raise "order_by_team_count failed to add all elements to the outputs" if array.length > 0
  output
end
