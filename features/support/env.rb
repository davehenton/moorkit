require 'simplecov'
SimpleCov.start

require 'database_cleaner'
require 'cucumber/rails'
require 'cucumber/api_steps'
require 'pry'


ENV['RAILS_ENV'] ||= 'test'

ActionController::Base.allow_rescue = false

DatabaseCleaner.clean_with(:deletion) # clean once, now

# run resque jobs to run inline/blocking/immediately
Resque.inline = true

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group)."
end

Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
  # { :except => [:widgets] } may not do what you expect here
  # as Cucumber::Rails::Database.javascript_strategy overrides
  # this setting.
  DatabaseCleaner.strategy = :truncation
end

Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
  DatabaseCleaner.strategy = :transaction
end

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

