FROM almalinux:8

# Install PHP and other packages
RUN dnf -q -y update && \
    dnf -q -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf -q -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm && \
    dnf -q -y module enable php:remi-8.1 && \
    dnf -q -y install php-fpm php-bcmath php-cli php-common php-devel php-gd php-intl php-json php-ldap php-mbstring  \
      php-mysqlnd php-pdo php-pear php-pecl-http php-pecl-redis5 php-pecl-zip php-soap php-xml php-xmlrpc \
      unzip wget zip git && \
    dnf clean all

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Add PHP-FPM pool config
COPY ./www.conf /etc/php-fpm.d/www.conf

# Prepare folders for FPM
RUN mkdir -p /var/log/php-fpm/ &&\
    mkdir /run/php-fpm/

EXPOSE 9000

CMD ["php-fpm", "-F"]
