FROM php:8.1

RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN apt-get install --yes zip
RUN apt-get install --yes git



ENV TZ="America/Sao_Paulo"

WORKDIR /var/www/
COPY . .
RUN chmod +x composerInstall.sh &&  ./composerInstall.sh &&  mv composer.phar /usr/local/bin/composer

RUN echo 'alias phpunit="clear;./vendor/bin/phpunit"' >> ~/.bashrc

EXPOSE 8000
CMD ["tail", "-f", "/dev/null"]
