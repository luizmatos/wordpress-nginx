FROM php7-fpm-base:latest

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html

RUN curl -L https://github.com/wp-cli/wp-cli/releases/download/v${WORDPRESS_CLI_VERSION}/wp-cli-${WORDPRESS_CLI_VERSION}.phar \
    -o /usr/local/bin/wp-cli.phar &&  \
    chmod +x /usr/local/bin/wp-cli.phar && \
    ln -s /usr/local/bin/wp-cli.phar /bin/wp && \
    wp --allow-root --version

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN  chmod +x /docker-entrypoint.sh

WORKDIR /var/www/html

VOLUME /var/www/html

USER www-data

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["wp", "shell"]
