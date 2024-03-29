FROM alpine:latest

# Set PHP version
ENV PHPV 81

# Install packages
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache ncdu

# Installing PHP
RUN apk add --no-cache php$PHPV \
    php$PHPV-common \
    php$PHPV-fpm \
    php$PHPV-pdo \
    php$PHPV-opcache \
    php$PHPV-zip \
    php$PHPV-phar \
    php$PHPV-iconv \
    php$PHPV-cli \
    php$PHPV-curl \
    php$PHPV-openssl \
    php$PHPV-mbstring \
    php$PHPV-tokenizer \
    php$PHPV-fileinfo \
    php$PHPV-json \
    php$PHPV-xml \
    php$PHPV-xmlwriter \
    php$PHPV-xmlreader \
    php$PHPV-simplexml \
    php$PHPV-dom \
    php$PHPV-gd \
    php$PHPV-pdo_mysql \
    php$PHPV-pdo_sqlite \
    php$PHPV-tokenizer \
    php$PHPV-calendar \
    php$PHPV-bcmath \
    php$PHPV-sockets \
    php$PHPV-intl \
    php$PHPV-soap \
    php$PHPV-pecl-redis \
    php$PHPV-posix \
    php$PHPV-pecl-xdebug

# Add user php-fpm
RUN adduser -u 82 -D -s /bin/ash -G www-data www-data
ENV USER www-data

# Add PHP-FPM pool config
COPY ./www.conf /etc/php81/php-fpm.d/www.conf

# Prepare folders for FPM
RUN mkdir -p /var/log/php-fpm/ &&\
    mkdir /run/php-fpm/ &&\
    chown $USER:$USER /run/php-fpm/ &&\
    chown $USER:$USER /var/log/php-fpm/ 


EXPOSE 9000

CMD ["php-fpm", "-F"]
