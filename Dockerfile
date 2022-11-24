FROM php:8.1-fpm-alpine

# Set PHP version
ENV PHPV 81

# Install packages
RUN apk add --no-cache ncdu icu-dev icu-data-full $PHPIZE_DEPS

# Install required libs for PHP extensions
#RUN apk add --no-cache libxml2-dev libzip-dev libpng-dev libressl-dev

# Install PHP extensions
RUN pecl install xdebug
RUN docker-php-ext-install intl pdo_mysql
RUN docker-php-ext-configure intl pdo_mysql --host=$BUILDPLATFORM --build=$BUILDPLATFORM --target=$TARGETPLATFORM 

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=intl/extension=intl/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=curl/extension=curl/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=gd/extension=gd/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=imap/extension=imap/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=ldap/extension=ldap/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=msbrting/extension=msbrting/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=mysqli/extension=mysqli/' /usr/local/etc/php.ini && \
	sed -i.bkp 's/^;extension=pdo_mysql/extension=pdo_mysql/' /usr/local/etc/php.ini

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
