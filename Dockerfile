FROM php:8.2-fpm

USER root

WORKDIR /var/www

RUN apt-get update \
	# gd
	&& apt-get install -y build-essential  openssl nginx libfreetype6-dev libjpeg-dev libpng-dev libpq-dev libicu-dev libwebp-dev zlib1g-dev libzip-dev gcc g++ make vim unzip curl git jpegoptim optipng pngquant gifsicle locales libonig-dev nodejs  \
	&& docker-php-ext-configure gd  \
	&& docker-php-ext-install gd \
	# gmp
	&& apt-get install -y --no-install-recommends libgmp-dev \
	&& docker-php-ext-install gmp \
	# pdo_mysql
	&& docker-php-ext-install pdo_pgsql mbstring \
	# pdo
	&& docker-php-ext-install pdo \
	# opcache
	&& docker-php-ext-enable opcache \
	# exif
    && docker-php-ext-install exif \
    && docker-php-ext-install sockets \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install intl \
	# zip
	&& docker-php-ext-install zip \
	&& apt-get autoclean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/pear/

COPY ./docker/php/php.ini /usr/local/etc/php/local.ini
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY composer.json composer.lock /var/www/

RUN chmod +rwx /var/www

RUN chmod -R 777 /var/www

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --working-dir="/var/www" --no-dev --optimize-autoloader --no-interaction --no-scripts

RUN composer dump-autoload --working-dir="/var/www" --no-scripts

COPY . /var/www

EXPOSE 80

RUN ["chmod", "+x", "./docker/post_deploy.sh"]

CMD [ "sh", "./docker/post_deploy.sh" ]
# CMD php artisan serve --host=127.0.0.1 --port=9000
