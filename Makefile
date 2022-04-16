DC = $(shell which docker-compose)

all: help

help:
	@echo "Available make commands:"
	@echo "  create          - Create new rails project mvc"
	@echo "  ps              - List containers"
	@echo "  build           - Build or rebuild services docker images for development"
	@echo "  bash            - Enter the application container and access bash"
	@echo "  bundle          - Install dependencies Gemfile"
	@echo "  yarn            - Install frontend dependencies"
	@echo "  dev             - Up application"
	@echo "  logs            - Show containers logs"
	@echo "  down            - Remove containers for services defined in the Compose file"
	@echo "  db-create       - Create database based in config/database.yml file"
	@echo "  db-migrate      - Migrations to database"

create:
	${DC} run --no-deps rails-app rails new . --force --database=postgresql

ps:
	${DC} ps

build:
	${DC} build --no-cache

bash:
	${DC} exec rails-app bash

bundle:
	${DC} run rails-app bin/rails bundle install

yarn:
	${DC} run rails-app yarn install

dev:
	${DC} up -d

logs:
	${DC} logs -f --tail=30

down:
	${DC} down --remove-orphans 

db-create:
	${DC} exec rails-app bin/rails db:create db:migrate

db-migrate:
	${DC} exec rails-app bin/rails db:migrate

db-drop:
	${DC} exec rails-app bin/rails db:drop