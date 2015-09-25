# StatsBuddy - Sinatra version
# First revision


require 'sinatra'
require 'slim'
require 'sass'
require './customer' # contains class for getting customer data
require './stats' # may replace "customer" but we'll see soon

configure do
  enable :sessions
  set :session_secret, 'thisiswhywecanthavenicethings'
  set :username, "admin"
  set :password, "w0kkaw0kka"

helpers do
  def css(*stylesheets)
    stylesheets.map do |stylesheets|
      "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\">"
end

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
    redirect to ('/stats')
  else
    slim :login
  end
end
