FROM php:5.6-fpm

RUN apt-get -y update && \
    apt-get -y install \
        nginx-full

RUN apt-get -y install \
        libxml2-dev \
        zlib1g-dev

RUN apt-get -y install \
        libpspell-dev

RUN docker-php-ext-install \
        dom \
        json \
        xml \
        mbstring \
        session \
        sockets \
        pdo \
        pdo_mysql \
        iconv \
        fileinfo \
        zip \
        pspell

RUN apt-get -y install \
        supervisor

RUN pear install mail_mime net_smtp net_idna2-beta auth_sasl net_sieve crypt_gpg

RUN curl -SL https://github.com/roundcube/roundcubemail/releases/download/1.2.2/roundcubemail-1.2.2-complete.tar.gz | tar xvz --strip-components=1

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    chown -R www-data:www-data /var/www/html

COPY etc/ /etc/
COPY usr/ /usr/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
