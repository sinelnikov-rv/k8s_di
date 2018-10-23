FROM php:7.2-apache
ENV APACHE_DOCUMENT_ROOT /var/www/html
ARG BUILD
VOLUME /var/www/html
#ENV BUILD wordpress-latest.tar.gz
RUN set -ex; \
    #sed -ri "s|/var/www/html|$APACHE_DOCUMENT_ROOT|" /etc/apache2/sites-available/*.conf; \
    #sed -ri "s|/var/www/|$APACHE_DOCUMENT_ROOT|g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf; \
    apt-get update; \
    docker-php-ext-install mysqli pdo_mysql; \
#    mkdir -p $APACHE_DOCUMENT_ROOT; \
    cd /tmp/; \
    curl https://s3-eu-west-1.amazonaws.com/cf-templates-1y0rf36bmollt-eu-west-1/$BUILD -o $BUILD; \
    mkdir -p /usr/src/wordpress; \
    tar -xzf $BUILD -C /usr/src/wordpress; \
    chown -R www-data:www-data /usr/src/wordpress
#   service apache2 restart
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
