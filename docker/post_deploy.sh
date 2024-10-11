#!/bin/sh

php artisan optimize

php artisan route:clear

php artisan route:cache

php artisan config:clear

php artisan config:cache

php artisan view:clear

php artisan view:cache

# start the application
php-fpm -D &&  nginx -g "daemon off;"
