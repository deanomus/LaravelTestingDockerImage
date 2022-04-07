FROM ubuntu

RUN apt update

RUN apt install lsb-release ca-certificates apt-transport-https software-properties-common -y && add-apt-repository ppa:ondrej/php && apt update

RUN apt install php8.1 php8.1-mysql php8.1-mbstring php8.1-curl php8.1-dom php8.1-zip php8.1-xdebug zip unzip git curl -y

RUN apt install libpng-dev libjpeg-dev -y

RUN docker-php-ext-install mcrypt pdo_mysql zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

ENV XDEBUG_MODE=coverage

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer