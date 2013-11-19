require 'bundler/setup'

require 'sinatra'
require 'haml'
require 'sinatra/activerecord'
require 'rake'
require 'chronic'

require 'rack-flash'

set :database, 'sqlite3:///twitter_clone_db_v0.sqlite3'

require './models'

get '/' do
	haml :index
end

get '/login' do
	haml :login
end

get '/signup' do
	haml :signup
end

get '/tweet' do
	haml :tweet
end

post '/tweet' do
	@tweet = Tweets.new
	@tweet.tweet_text = params[:tweet_text]
	@tweet.tweet_time = Time.now
	#@tweet.userid 
	@tweet.save
end

post '/signup' do
	@user = User.new
	@user.fname = params[:fname]
	@user.lname = params[:lname]
	@user.email = params[:email]
	@user.username = params[:username]
	@user.password = params[:password]
	@user.save
end