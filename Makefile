RUBY_VER=$(shell (head -n 1 .ruby-version))
DB_USER=moorkit
DB_PASSWORD=moorkit
DB_NAME=development
PG_ADMIN_URL="postgres://localhost:5432/$(DB_NAME)"
PG_URL="postgres://$(DB_USER):$(DB_PASSWORD)@localhost:5432/$(DB_NAME)"

CWD=$(shell pwd)

setup: setup-basic
	echo "Setup Complete"

setup-basic:
	bash -c 'cd ../../.rbenv/plugins/ruby-build && git checkout master && git pull'
	echo "Installing Ruby $(RUBY_VER)..."
	rbenv install $(RUBY_VER) -s
	gem install bundle
	bundle install

setup-heroku:
	wget -O- https://toolbelt.heroku.com/install.sh | sh

test: specs cukes
	@echo "\nTesting Complete\n"

specs:
	RAILS_ENV=test bundle exec rspec

cukes:
	RAILS_ENV=test bundle exec cucumber

db-migrate:
	bundle exec rake db:migrate

db-reset: db-drop-all db-migrate
	bundle exec rake db:seed
	echo "Reset Complete"

db-load:
	bundle exec rake db:schema:load

db-setup: db-createdb db-user db-migrate

db-drop-all:
	psql -d $(PG_URL) -c "DROP OWNED BY $(DB_USER);"

db-createdb:
	createdb $(DB_NAME)

db-user:
	psql -d $(PG_ADMIN_URL) -c "CREATE USER $(DB_USER) WITH PASSWORD '$(DB_PASSWORD)' SUPERUSER;"
	psql -d $(PG_ADMIN_URL) -c 'GRANT ALL PRIVILEGES ON DATABASE "$(DB_NAME)" TO "$(DB_USER)";'
