FROM php:8.1.7-fpm-alpine


RUN apk update

RUN apk add zip unzip git curl libzip libzip-dev libpng libpng-dev libjpeg libjpeg-turbo libjpeg-turbo-dev freetype-dev icu-dev mariadb-client mariadb-connector-c

RUN apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install redis-5.3.7 \
    && apk add --update linux-headers \
    && pecl install xdebug-3.2.2 \
    && docker-php-ext-enable redis xdebug

RUN docker-php-ext-install pdo_mysql zip bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-configure intl
RUN docker-php-ext-install -j$(nproc) gd intl

ENV XDEBUG_MODE=coverage

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer
