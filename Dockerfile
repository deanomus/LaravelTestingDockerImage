FROM php:8.1-alpine


RUN apk update

RUN apk add zip unzip git curl libzip libzip-dev libpng libpng-dev libjpeg libjpeg-turbo libjpeg-turbo-dev freetype-dev

RUN apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install redis-5.3.7 \
    && pecl install xdebug-3.1.3 \
    && docker-php-ext-enable redis xdebug

RUN docker-php-ext-install pdo_mysql zip bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

ENV XDEBUG_MODE=coverage

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer