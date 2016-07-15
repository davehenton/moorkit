source 'https://rubygems.org'


gem 'bundler', '1.12.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '0.18.4'
# Use redis for resque and other value/key storage
gem 'redis', '3.3.0'
# Use for managing background workers
gem 'resque','1.26.0'

#Use grape to create REST-like APIs in Ruby
gem 'grape', '0.16.2'
# Build JSON output with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.5.0'

#secure the API via OAuth using Doorkeeper
gem 'doorkeeper', '4.0.0'
# use wine_bouncer to bind API authentication to Doorkeeper
gem 'wine_bouncer', '1.0.0'

#tie multiple oauth2 strategies to Doorkeeper
gem 'omniauth', '1.3.1'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-google-oauth2', '0.4.1'
gem 'omniauth-facebook', '3.0.0'
gem 'omniauth-linkedin-oauth2', '0.1.5'


# ########## HTML Stuff ##########
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '3.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails', '4.1.1'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.5.3'

# Use static asset serving for Heroku
group :production do
  gem 'rails_12factor', '0.0.3'
end
# Use puma web server
gem 'puma', '3.4.0'

group :test do
  gem 'factory_girl_rails', '4.7.0'
  gem 'rspec', '3.4.0'
  gem 'cucumber', '2.4.0'
  gem 'cucumber-api-steps', '0.13'
  gem 'rack-test', '0.6.3'
  gem 'database_cleaner', '1.5.3'
  gem 'codeclimate-test-reporter', '0.6.0'
end

group :development, :test do
  gem 'rspec-rails', '3.4.2'
  gem 'cucumber-rails', '1.4.3', require: false
  gem 'byebug', '9.0.5'
  gem 'pry', '0.10.3'
  gem 'pry-rails', '0.3.4'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.7.1'
end

ruby "2.3.1"
