FROM php:8.1-alpine


RUN apk update

RUN apk add zip unzip git curl

RUN pecl install redis-5.3.7 \
    && pecl install xdebug-3.1.3 \
    && docker-php-ext-enable redis xdebug

RUN docker-php-ext-install mcrypt pdo_mysql zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

ENV XDEBUG_MODE=coverage

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer