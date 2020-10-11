#!/bin/sh

 # Install dependencies
echo "Running composer install..."
php -d memory_limit=-1 /usr/bin/composer install

# Run migrations
echo "Executing migrations..."
php bin/console doctrine:migrations:migrate --no-interaction
