FROM ubuntu

RUN apt update

RUN apt install lsb-release ca-certificates apt-transport-https software-properties-common -y && add-apt-repository ppa:ondrej/php && apt update

RUN apt install php8.1 php8.1-mysql -y


