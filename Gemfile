source 'https://rubygems.org'
ruby '2.2.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'

gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'

gem "therubyracer"

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rvm'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1'
gem 'select2-rails', '3.5.9.1'

# Use Ember.js for frontend javascript
gem 'ember-rails'
gem 'ember-source', '2.5.1'
gem 'ember-data-source', '2.5.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'posix-spawn'
gem 'oink'

gem 'spree', github: 'spree/spree', branch: '3-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'
gem 'spree_gateway', github: 'spree/spree_gateway', branch: '3-0-stable'

gem 'valid_email'

group :development, :test do
  gem 'bullet'
	gem 'better_errors'
	gem 'binding_of_caller'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :production do
	gem 'unicorn'
end
