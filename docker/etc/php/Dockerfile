FROM php:8.3-fpm

ARG UID
ARG GID

RUN apt-get update && apt-get install -y git libzip-dev procps vim

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions intl amqp bcmath mongodb opcache openssl curl zip xsl sodium

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN groupmod -o -g ${GID} www-data && usermod -o -u ${UID} -g www-data www-data

# Symfony CLI https://symfony.com/download
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony
RUN mkdir /var/www/.symfony5 && \
    chown www-data:www-data /var/www/.symfony5

USER www-data

WORKDIR /var/www/backend

CMD COMPOSER_MEMORY_LIMIT=-1 composer install ; php-fpm
