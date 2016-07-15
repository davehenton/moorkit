# Sherlock

[![Build Status](https://travis-ci.org/ac21/moorkit.svg?branch=master)](https://travis-ci.org/ac21/moorkit)
[![Code Climate](https://codeclimate.com/github/ac21/moorkit/badges/gpa.svg)](https://codeclimate.com/github/ac21/moorkit)
[![Test Coverage](https://codeclimate.com/github/ac21/moorkit/badges/coverage.svg)](https://codeclimate.com/github/ac21/moorkit/coverage)

A basic application for investigating users

## Dependencies
*   Ruby 2.3.1
*   Postgres 9.4.0 or later
*   Redis

## Setup
*   create environmental variables in ``config.dev``; run ``source config.dev`` to load.  See config.example for necessary variables
*   run setup: ``make setup``
*   start containers: ``make start-containers``
*   prep postgres for custom config because of the need for extensions
```sh
attach postgres94-1
sudo -i -u postgres psql -c "ALTER USER admin WITH SUPERUSER;"
exit
```
*   setup db and db user ``make db-user db-load db-migrate``

## Running
* run ``bundle exec rails s`` runs just the rails app
OR

## Running on Heroku
*   Setup Heroku CLI ``make setup-heroku``
*   Login to heroku: ``heroku login``
*   Run ``foreman start`` tests Procfile and other workers

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
