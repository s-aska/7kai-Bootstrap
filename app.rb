require 'rubygems' unless defined? ::Gem
require 'sinatra'

# 設定
if development?
	use Rack::Session::Cookie,
		:secret => Digest::SHA1.hexdigest(rand.to_s)
else
	# sudo yum install memcached
	# sudo /etc/init.d/memcached start
	# gem install dalli
	require 'rack/session/dalli'
	use Rack::Session::Dalli,
		:memcache_server => 'localhost:11211',
		:expire_after => 3600,
		:namespace => 'bootstrap.7kai.org'
end

get '/' do
	session[:count] = ( session[:count] || 0 ) + 1
	'Hello world! ' + session[:count].to_s
end