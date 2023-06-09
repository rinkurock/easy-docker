FROM php:7.1.1-fpm

RUN apt-get update

RUN docker-php-ext-install mbstring

RUN curl -sL https://github.com/ptrofimov/beanstalk_console/archive/master.tar.gz | tar xvz -C /tmp

RUN mv /tmp/beanstalk_console-master/* /var/www/html/

ADD config/apache_default /etc/apache2/apache2.conf
ADD config/apache_vhost  /etc/apache2/sites-available/000-default.conf
ADD config/apache_vhost_ssl /etc/apache2/sites-available/default-ssl.conf
ADD config/php.ini /usr/local/lib/php.ini

ENV BEANSTALKD_HOST beanstalkd
ENV BEANSTALKD_PORT 11300
ENV APACHE_PORT 80
ENV APACHE_SSL_PORT 443
ENV APACHE_WORKDIR /var/www/html

# Add custom entrypoint to inject runtime environment variables into
# beanstalk console config
ADD config/run.sh /usr/local/bin/run

# Change ownership for apache happiness & install Composer
RUN chmod +x /usr/local/bin/run && \
    chown -R www-data:www-data /var/www/html && \
    a2enmod rewrite

WORKDIR /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install

CMD ["/usr/local/bin/run"]