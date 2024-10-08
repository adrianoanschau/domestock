FROM alpine:3.20

MAINTAINER Adriano Anschau <adrianoanschau@gmail.com>

WORKDIR /var/www/html/

RUN echo "UTC" > /etc/timezone
RUN apk add --no-cache zip unzip curl sqlite nginx supervisor

RUN apk add bash
RUN sed -i 's/bin\/ash/bin\/bash/g' /etc/passwd

# Installing PHP
RUN apk add --no-cache php83 \
    php83-common \
    php83-fpm \
    php83-pdo \
    php83-opcache \
    php83-zip \
    php83-phar \
    php83-iconv \
    php83-cli \
    php83-curl \
    php83-openssl \
    php83-mbstring \
    php83-tokenizer \
    php83-fileinfo \
    php83-json \
    php83-xml \
    php83-xmlwriter \
    php83-xmlreader \
    php83-simplexml \
    php83-dom \
    php83-pdo_mysql \
    php83-pdo_pgsql \
    php83-pdo_sqlite \
    php83-tokenizer \
    php83-pecl-redis \
    php83-intl \
    php83-pcntl

# RUN #ln -s /usr/bin/php83 /usr/bin/php

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN rm -rf composer-setup.php

# Configure supervisor
RUN mkdir -p /etc/supervisor.d/
COPY docker/supervisord.ini /etc/supervisor.d/supervisord.ini

# Configure PHP
RUN mkdir -p /run/php/
RUN touch /run/php/php8.3-fpm.pid

COPY docker/php-fpm.conf /etc/php83/php-fpm.conf
COPY docker/php.ini-production /etc/php83/php.ini

# Configure nginx
COPY docker/nginx.conf /etc/nginx/
COPY docker/nginx-laravel.conf /etc/nginx/modules/

RUN mkdir -p /run/nginx/
RUN touch /run/nginx/nginx.pid

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Building process
COPY . .
RUN composer install --no-dev
RUN chown -R nobody:nobody /var/www/html/storage

EXPOSE 8080
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.ini"]
