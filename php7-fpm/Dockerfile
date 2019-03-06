FROM php:7-fpm-alpine

# Instalando dependências

RUN apk add --no-cache \
	bash \
	ca-certificates \
	git \
	tar \
	libmemcached \
	libmemcached-dev \
	libjpeg-turbo-dev \
	sed \
	libpng-dev \
	nano

# Instalando dependencias PHP
RUN mkdir -p /usr/src/php/ext/

# Install Memcached
RUN set -xe && \
    cd /tmp/ && \
    apk add --no-cache --virtual .build-deps \
	libpq \
	zlib \
	zlib-dev \
	unzip \
	openssl-dev \
        pcre-dev \
	libzip-dev && \
    curl -o memcached.tgz -SL http://pecl.php.net/get/memcached && \
	tar -xf memcached.tgz -C /usr/src/php/ext/ && \
	echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini && \
	rm memcached.tgz && \
	mv /usr/src/php/ext/memcached-* /usr/src/php/ext/memcached && \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli opcache memcached && \
    apk del .build-deps

# Install PHP Memcached extensions

RUN set -xe && \
    cd /tmp/ && \
    apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS && \
    apk add --no-cache --update --virtual .memcached-deps zlib-dev libmemcached-dev cyrus-sasl-dev && \
    pecl install igbinary && \
    ( \
        pecl install --nobuild memcached && \
        cd "$(pecl config-get temp_dir)/memcached" && \
        phpize && \
        ./configure --enable-memcached-igbinary && \
        make -j$(nproc) && \
        make install && \
        cd /tmp/ \
    ) && \
    docker-php-ext-enable igbinary memcached && \
    rm -rf /tmp/* && \
    apk del .memcached-deps .phpize-deps

# Install ZIP

RUN set -xe && \
    apk add --no-cache --virtual .zip-deps zlib-dev libzip-dev && \
	curl -o zip.tgz -SL http://pecl.php.net/get/zip && \
	tar -xf zip.tgz -C /usr/src/php/ext/ && \
	rm zip.tgz && \
	mv /usr/src/php/ext/zip-* /usr/src/php/ext/zip && \
    docker-php-ext-install zip


# https://secure.php.net/manual/en/opcache.installation.php

RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php-fpm"]
