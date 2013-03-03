7kai-Bootstrap
==============

# 環境構築

system ruby ではなく user ruby を使う

### CentOS (sudo)

	$ sudo yum install sqlite-devel sqlite openssl openssl-devel readline-devel readline compat-readline5 libxml2-devel libxslt-devel libcurl curl wget git

### Ubuntu (sudo)

	$ sudo apt-get install build-essential libreadline-dev libssl-dev zlib1g-dev

## rbenv / ruby-build のインストール

	$ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
	$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
	$ source ~/.bashrc

	$ git clone git://github.com/sstephenson/ruby-build.git
	$ cd ruby-build
	$ sudo ./install.sh
	$ cd ../

## ruby のインストール

	# 新しいバージョンを確認
	$ rbenv install -l
	$ rbenv install 1.9.3-p392
	$ rbenv global 1.9.3-p392

	$ which ruby
	$ which gem

## foreman / sinatra / unicorn のインストール

	$ gem install foreman sinatra unicorn
	# rehashしないとパスが通らないので注意
	$ rbenv rehash
	$ which foreman
	$ which unicorn

## 起動

	$ cd 7kai-Bootstrap
	$ foreman start

