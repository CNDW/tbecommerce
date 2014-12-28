source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rvm'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.2'
gem 'select2-rails', '3.5.9.1'

# Use Ember.js for frontend javascript
gem 'ember-rails'
gem 'ember-source', '1.8.1'
gem 'ember-data-source', '1.0.0.beta.14'

# Use emblem for javascript templates
gem 'emblem-rails'

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

gem 'spree', github: 'spree/spree', branch: '2-4-stable'
gem 'spree_auth_devise', :github => 'spree/spree_auth_devise', :branch => '2-4-stable'
gem 'spree_gateway', github: 'spree/spree_gateway', branch: '2-4-stable'

gem 'valid_email'

group :development, :test do
  gem 'bullet'
	gem 'better_errors'
	gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

group :production do
	gem 'unicorn'
end