require 'bundler/setup'

require 'sinatra'
require 'haml'
require 'sinatra/activerecord'
require 'rake'
require 'chronic'
require 'bcrypt'
require 'rack-flash'

configure(:development) { set :database, 'sqlite3:///twitter_clone_db_v0.sqlite3' }

require './models'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions => true


helpers do
	def current_user
		if session[:user_id]
			User.find(session[:user_id])
		else
			nil
		end
	end
end

get '/' do
	@users = User.all
	@tweets = Tweet.all
	haml :index
end


get '/login' do
	haml :login
end

post '/login' do
	@user = User.authenticate(params['user']['username'], params['user']['password'])
	if @user
		session[:user_id] = @user.id
		flash[:notice] = "You've signed in successfully!"
		redirect '/'
	else
		flash[:notice] = "There was a problem signing you in."
		redirect '/login'
	end
end


get '/signup' do
	haml :signup
end


post '/signup' do
	@user = User.new(params['user'])
	if @user.save
		session[:user_id] = @user.id
		flash[:notice] = "You have signed up successfully!"
		redirect '/'
	else
		flash[:alert] = "There was a problem creating your account."
		redirect '/signup'
	end
end


get '/user/:id' do
	@user = User.find(params[:id])
	haml :profile
end


post '/newtweet' do
	if current_user
		@tweet = Tweet.new(tweet_text: params['tweet_text'], tweet_time: Time.now, user_id: current_user.id)
		if @tweet.save
			flash[:notice] = "Your tweet was posted!"
		else
			flash[:alert] = "There was a problem posting your tweet."
		end
			redirect "/user/#{current_user.id}"
	end
end	


get '/signout' do
	session[:user_id] = nil
	flash[:notice] = "You've been signed out."
	redirect '/'
end
