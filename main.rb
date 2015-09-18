# StatsBuddy - Sinatra version
# First revision


require 'sinatra'
require 'slim'
require 'sass'
require './customer' # contains class for getting customer data

configure do
  enable :sessions
  set :session_secret, 'thisiswhywecanthavenicethings'
  set :username, # fill in with a username
  set :password, # fill in with a password

get '/' do
  redirect to ('/login') unless session[:admin]
  slim :home
end

get '/login' do
  slim :login
end

get '/logout' do
  session.clear
  redirect to('/login')
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to ('/songs')
  else
    slim :login
  end
end
