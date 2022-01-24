FROM ubuntu

RUN apt update

RUN apt install lsb-release ca-certificates apt-transport-https software-properties-common -y && add-apt-repository ppa:ondrej/php && apt update

RUN apt install php8.1 php8.1-mysql php8.1-mbstring php8.1-curl php8.1-dom git -y

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer