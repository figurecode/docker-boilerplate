.PHONY: all

SHELL=/bin/bash -e

help: ## Справка
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

info: ## Шпаргалка по установке из README.md
	@sed '/start/,/```/!d;/```/q' README.md | grep -v '```'


##################
# Docker compose
##################
rebuild: ## Сборка контейнеров без кеша и запуска проекта
	docker compose -f docker/docker-compose.yml build --no-cache

up: ## Запуск проекта
	docker compose -f docker/docker-compose.yml up -d

down: ## Остановка всех контейнеров проекта
	docker compose -f docker/docker-compose.yml down

bash-php: ## Зайти в bash контейнера с php
	docker compose -f docker/docker-compose.yml exec php-fpm /bin/bash

bash-mongo: ## Зайти в bash контейнера с mongodb
	docker compose -f docker/docker-compose.yml exec mongodb sh

bash-rabbit: ## Зайти в bash контейнера с rabbit
	docker compose -f docker/docker-compose.yml exec rabbit sh
