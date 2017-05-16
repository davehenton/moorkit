RUBY_VER=$(shell (head -n 1 .ruby-version))
DB_USER=moorkit
DB_PASSWORD=moorkit
DB_NAME=moorkit
PG_URL="postgres://$(DB_USER):$(DB_PASSWORD)@localhost:5432/$(DB_NAME)"

CWD=$(shell pwd)

setup: setup-basic set-env
	echo "Setup Complete"

set-env:
	export $(xargs -a .env)

setup-basic:
	bash -c 'cd ../../.rbenv/plugins/ruby-build && git checkout master && git pull'
	echo "Installing Ruby $(RUBY_VER)..."
	rbenv install $(RUBY_VER) -s
	gem install bundler --version 1.12.5
	bundle install

test: specs cukes
	@echo "\nTesting Complete\n"

specs:
	RAILS_ENV=test bundle exec rspec

cukes:
	RAILS_ENV=test bundle exec cucumber

db-migrate:
	bundle exec rake db:migrate

db-reset: db-drop-tables db-migrate
	bundle exec rake db:seed
	echo "Reset Complete"

db-load:
	bundle exec rake db:schema:load

db-setup: db-createuser db-createdb db-migrate

db-wipe: db-dropdb db-dropuser

db-drop-tables:
	psql -d $(PG_URL) -c "DROP OWNED BY $(DB_USER);"

db-createdb:
	sudo -u postgres psql -c 'CREATE DATABASE $(DB_NAME) WITH OWNER = $(DB_USER);'

db-dropdb:
	sudo -u postgres dropdb $(DB_NAME)

db-createuser:
	sudo -u postgres psql -c "CREATE USER $(DB_USER) WITH PASSWORD '$(DB_PASSWORD)' SUPERUSER;"

db-dropuser:
	sudo -u postgres dropuser $(DB_USER)

db-travis: db-travis-setup db-migrate

db-travis-setup:
	psql -U postgres -c 'create database moorkit'
