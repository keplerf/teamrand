require 'sinatra'
require 'sinatra/reloader'
require 'faker'

enable :sessions
use Rack::MethodOverride

def teamBuilder(arrayInit,team)
  array = arrayInit.split(", ").shuffle!
  teams = []
  team.times do |x|
    teams.push([])
  end
  counter = 0
  until array.length == 0
    teams[counter.remainder(team)].push(array.pop)
    counter += 1
  end
  p teams
end

def randoByNumberOfMember(arrayInit,team)
  array = arrayInit.split(", ").shuffle!
  teams =[]
  array.each_slice(team) do |group|
    teams.push(group)
  end
  teams
end

get '/team' do
  erb :team, layout: :layout
end

post '/team' do
  @names = params[:names]
  @team = params[:team].to_i
  @method = params[:method]
  if @method == "team_count"
    @teams = teamBuilder(@names,@team)
  elsif @method == "per_team"
    @teams = randoByNumberOfMember(@names,@team)
  end

  erb :team, layout: :layout
end
