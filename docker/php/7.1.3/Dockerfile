#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM php:7.1.3-fpm

MAINTAINER Syed Abidur Rahman <aabid048@gmail.com>

RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get -o Acquire::Check-Valid-Until=false update \
  && apt-get install -y --no-install-recommends \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    supervisor \
    nano \
    zip unzip \
    libssh2-1-dev \
    openssl \
    libxml2-dev


# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql \
  # Install the PHP pdo_pgsql extention
  && docker-php-ext-install pdo_pgsql \
  # Install the PHP gd library
  && docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 \
  && docker-php-ext-install gd


# Install various PHP extentions
RUN docker-php-ext-install tokenizer \
  && docker-php-ext-install -j$(nproc) mcrypt \
  && docker-php-ext-install -j$(nproc) pdo \
  && docker-php-ext-install mbstring \
    #&& docker-php-ext-install simplexml \
  && docker-php-ext-install ctype \
  && docker-php-ext-install json \
  && docker-php-ext-install bcmath \
  && docker-php-ext-install sysvsem


# Install the mysql-client for mysqldump
RUN apt-get update \
  && apt-get install -y mysql-client


# Composer setup
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# xDebug installation
RUN yes | pecl install xdebug \
  && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
  && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
  && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini


RUN pecl install -o -f redis \
  && rm -rf /tmp/pear \
  && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini


#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default work directory
WORKDIR /var/www
