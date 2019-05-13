FROM nginx:alpine

RUN apk add bash openssl curl

RUN rm -f /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/conf.d/example_ssl.conf

COPY wordpress.conf /etc/nginx/conf.d/wordpress.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]
CMD ["nginx"]
