FROM alpine:3

# Set PHP version
ENV PHPV 81

# Install PHP, NGINX and other packages
RUN apk add nginx php$PHPV-fpm php$PHPV-bcmath php$PHPV-cli php$PHPV-common php$PHPV-gd php$PHPV-intl php$PHPV-json php$PHPV-ldap \
			php$PHPV-mbstring php$PHPV-mysqlnd php$PHPV-pdo php$PHPV-pear php$PHPV-opcache ncdu && rm -rf /var/cache/apk/*

# Add user php-fpm
RUN addgroup -g 1000 www
RUN adduser -u 1000 -H -D -G www www

# Add PHP-FPM pool config
COPY ./www.conf /etc/php-fpm.d/www.conf

# Prepare folders for FPM
RUN mkdir -p /var/log/php-fpm/ &&\
    mkdir /run/php-fpm/

EXPOSE 9000

CMD ["php-fpm", "-F"]
