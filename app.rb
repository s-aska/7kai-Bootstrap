require 'rubygems' unless defined? ::Gem
require 'sinatra'
require 'erubis'
require 'oauth'

set :erb, :escape_html => true

callback_url = 'http://127.0.0.1:4567/callback'

# 設定
if development?
	use Rack::Session::Cookie,
		:secret => Digest::SHA1.hexdigest(rand.to_s)
else
	# sudo yum install memcached
	# sudo /etc/init.d/memcached start
	# gem install dalli
	require 'dalli'
	require 'rack/session/dalli'
	use Rack::Session::Dalli, :cache => Dalli::Client.new
	callback_url = 'http://bootstrap.7kai.org/callback'
end

consumer = OAuth::Consumer.new(
	ENV["TW_CONSUMER_KEY"],
	ENV["TW_CONSUMER_SECRET"],
	:site => 'https://api.twitter.com')

get '/' do

	# テンプレートのファイル名を指定（index.erubis）
	erb :index, :locals => {:access_token => session[:access_token]}
end

# セッションがちゃんと取れるかのテスト
get '/count' do
	session[:count] = ( session[:count] || 0 ) + 1
	'Hello world! ' + session[:count].to_s
end

get '/signin' do
	request_token = consumer.get_request_token(:oauth_callback => callback_url)
	session[:request_token] = request_token
	redirect request_token.authorize_url
end

get '/signout' do
	session.clear
	redirect '/'
end

get '/callback' do
	request_token = session[:request_token]
	if request_token then
		access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
		session[:access_token] = access_token
	end
	redirect '/'
end

post '/t' do
	access_token = session[:access_token]
	if access_token then
		access_token.post('https://api.twitter.com/1.1/statuses/update.json', 'status' => params[:status])
		access_token.post('https://api.twitter.com/1.1/statuses/update.json', 'status' => params[:status] + ' x2')
		access_token.post('https://api.twitter.com/1.1/statuses/update.json', 'status' => params[:status] + ' x3')
		access_token.post('https://api.twitter.com/1.1/statuses/update.json', 'status' => params[:status] + ' x4')
		access_token.post('https://api.twitter.com/1.1/statuses/update.json', 'status' => params[:status] + ' x5')
	end
	redirect '/'
end
