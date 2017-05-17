# Moorkit

[![Build Status](https://travis-ci.org/ac21/moorkit.svg?branch=master)](https://travis-ci.org/ac21/moorkit)
[![Code Climate](https://codeclimate.com/repos/5789d9dcf7959a007f004277/badges/594d0c621b9235f67146/gpa.svg)](https://codeclimate.com/repos/5789d9dcf7959a007f004277/feed)
[![Test Coverage](https://codeclimate.com/repos/5789d9dcf7959a007f004277/badges/594d0c621b9235f67146/coverage.svg)](https://codeclimate.com/repos/5789d9dcf7959a007f004277/coverage)

A basic application for investigating users

## Dependencies
*   Ruby 2.3.1
*   Postgres 9.4.0 or later
*   Redis

## Setup
Note: Setup assumes you are using vagrant/virtualbox [dev-vm-rails5](https://github.com/ac21/dev-vm-rails5)
*   create environmental variables in `.env`;  you can use `example.env` as inspiration; run `export $(xargs -a .env)` to load.  See config.example for necessary variables
*   run setup: `make setup`
*   run databse setup: `make db-setup`

## Running
* run ``bundle exec rails s`` runs just the rails app
OR

## Running on Heroku
*   Login to heroku: `heroku login`
*   Run `heroku local` tests Procfile and other workers


## Buidling on Heroku
*  create the application `heroku create moorkit`
*  push the code to heroku `git push heroku master`
*  run the migrations `heroku run rake db:migrate`
*  set environmental configuration:
```
heroku config:set WEB_CONCURRENCY=2 RAILS_MAX_THREADS=4 DATABASE_CONNECTIONS=9 MK_RESQUE_CREDS=[USERNAME]:[PASSWORD]
```

## License

This app is open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
