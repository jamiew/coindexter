source 'https://rubygems.org'

ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#Bootstrap
gem 'bootstrap-sass', '3.3.6'
#Convert checkboxes to switches
gem 'bootstrap-switch-rails', '~> 3.0.0'

# Image uploads
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
# gem 'carrierwave_direct'
gem 'mini_magick'
gem 'fog-aws'

# url slugs
gem 'friendly_id', '~> 5.1.0'

#make API calls
gem 'httparty'

#authentication
gem 'devise'
gem 'omniauth-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'twitter'
gem 'omniauth-google-oauth2'

#environmental variables
gem 'dotenv-rails', :groups => [:development, :test]

#database 
gem 'pg'

#search
gem 'pg_search'

#fix jquery onload
gem 'jquery-turbolinks'

#paginate links
gem 'will_paginate', '~> 3.1.0'

#for the log
gem 'paper_trail'

#emailing
gem 'mailgun_rails'
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'

#readpdfs
gem 'pdf-reader'

#calendar
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'jquery-ui-rails'

#following model
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'

# know what browswer it is in view
gem 'browser'

# retina images
gem 'retina_tag'

gem 'pry'

gem 'sidekiq'

gem 'foreman'

gem 'sitemap_generator'

group :production do 
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use sqlite3 as the database for Active Record
	gem 'sqlite3'
end


