FROM php7-fpm-base:latest

ENV WORDPRESS_VERSION 5.1

VOLUME /var/www/html

RUN set -ex; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
	chown -R www-data:www-data /usr/src/wordpress

# Install wordpress extensions: WP-FFPC
RUN cd /usr/src/wordpress/wp-content/plugins && \
    curl -o wp-ffpc.zip -L https://downloads.wordpress.org/plugin/wp-ffpc.zip && \
    unzip -o wp-ffpc.zip && \
    chown -R www-data:www-data wp-ffpc && \
    rm -f wp-ffpc.zip

#Enable Wordpress Caching
RUN cd /usr/src/wordpress && ls -l && \
    sed -ri -e "s#(<\?php)#\\1\ndefine('WP_CACHE', 'true');#g" wp-config-sample.php

RUN cp -rfp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
