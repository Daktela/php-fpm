FROM alpine:latest

# Set PHP version
ENV PHPV 81

# Install packages
RUN apk add --no-cache ncdu

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
    php$PHPV-pecl-redis \
    php$PHPV-pecl-xdebug

# Add user php-fpm
RUN addgroup -g 1000 www
RUN adduser -u 1000 -H -D -G www www
RUN addgroup www wheel

# Add PHP-FPM pool config
COPY ./www.conf /etc/php-fpm.d/www.conf

# Prepare folders for FPM
RUN mkdir -p /var/log/php-fpm/ &&\
    mkdir /run/php-fpm/


EXPOSE 9000

CMD ["php-fpm", "-F"]
