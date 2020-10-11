FROM php:fpm-alpine

COPY docker-wait-for-it.sh /usr/bin/wait-for-it
RUN chmod +x /usr/bin/wait-for-it
RUN apk --update --no-cache add git bash libpng-dev libjpeg-turbo-dev freetype-dev
RUN set -ex && apk --no-cache add postgresql-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo pdo_pgsql intl gd
RUN apk --no-cache add $PHPIZE_DEPS rabbitmq-c-dev
RUN pecl install amqp && docker-php-ext-enable amqp
RUN echo "memory_limit = 1024M;" >> /usr/local/etc/php/conf.d/docker-php-memorylimit.ini
COPY --from=composer /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/server
CMD COMPOSER_MEMORY_LIMIT=-1 composer install ; wait-for-it ratio-postgres:5432 -- bin/console doctrine:migrations:migrate ; ./docker-run-workers.sh ; php-fpm
EXPOSE 9000
