# docker-boilerplate
Заготовки Dockert-контейнеров для внутренних разработок

Что нужно сделать:

1. Установить и запустить Docker
1. Клонировать репозиторий  `git clone git@github.com:figurecode/docker-boilerplate.git`. 
1. Переключить ветку в нужную конфигурацию
1. Открыть файл `/etc/hosts` и добавить в строку `127.0.0.1 localhost` домен `ratio.local`;
1. Перейти в директорию, написать `docker-compose up --build`.
1. Начать работу в нужной вам директории !*описать подробнее*!


## Структура проекта

Репозиторий состоит из следующих директорий:

- `bin` — хранит скрипты которые используются для обслуживания платформы;
- `etc` — настройки инфраструктуры;
- `etc/nginx` — настройки Nginx;
- `etc/postgres` — дампы и скрипты для PostgreSQL;
- `client/site` — !не настроено, но должен быть NUXT!
- `server` — Symfony-приложение для API.

## Структура контейнеров

- `ratio-nginx` — контейнер содержит веб-сервер:
    - Порт: `80`;
    - Домен: `ratio.local`;
- `ratio-postgres` — база данных PostreSQL:
    - Порт: `5432`;
    - Хост: `ratio-postgres` или `localhost`;
    - Пользователь: `ratio-user`;
    - Пароль: `ratio-password`;
    - База данных: `ratio`;
    - При запуске разворачивает дамп из `/etc/postgres/`;
- `ratio-rabbit` — брокер сообщений RabbitMQ:
    - Порт: `5672`;
    - Хост: `ratio-rabbit` или `localhost`;
    - Админка: `localhost:15672`;
    - Пользователь: `ratio-user`;
    - Пароль: `ratio-password`;
- `ratio-redis` — база данных Redis:
    - Порт: `6379`;
    - Хост: `ratio-redis` или `localhost`;
- `ratio-server` — API-приложение на symfony;
    - Запускается через `php-fpm`;
    - При запуске выполняет `composer install`;
    - При запуске выполняет миграции `doctrine:migrations:migrate`;

## Выполнение команд в контейнерах

Вы можете подключится к контейнеру командой:

`docker exec -it {{название контейнера}} /bin/sh`

например, для контейнера `ratio-server`:

`docker exec -it ratio-server /bin/sh`

а можете сразу исполнять команды в нём, например:

`docker exec -it ratio-server ./bin/console cache:clear`

## Работа с асинхронными воркерами в контейнерах

По умолчанию при запуске запускаются все воркеры через `./docker-run-workers.sh`, но бывает нужно перезапустить воркер в ручную. 

Для этого нужно сначала зайти и выключить воркер в контейнере: `docker exec -it ratio-server /bin/bash -c "ps ax | pgrep -f 'vorker-name' | xargs kill"`, а затем запустить его вручную, например: `docker exec -it ratio-server bin/console messenger:consume vorker-name -vv`.