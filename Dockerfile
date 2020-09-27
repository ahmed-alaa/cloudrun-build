FROM composer AS composer

# copying the source directory and install the dependencies with composer
COPY ./ /app

# run composer install to install the dependencies
RUN composer install \
  --optimize-autoloader \
  --no-interaction \
  --no-progress \
  --no-dev && \
  composer dump-autoload --no-dev --classmap-authoritative

FROM php:7.4-fpm-alpine

RUN apk --no-cache add php7-opcache php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd nginx supervisor curl && \
    rm /etc/nginx/conf.d/default.conf

# Configure nginx
COPY ./Infrastructure/nginx/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY ./Infrastructure/php/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY ./Infrastructure/php/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY ./Infrastructure/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

#  Change ownership to nobody
RUN chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/log/nginx

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www/html
COPY --chown=nobody --from=composer /app /var/www/html

ENV APP_ENV=prod

# Expose the port nginx is reachable on
EXPOSE 8080

RUN php bin/console cache:clear --no-warmup && \
  php bin/console cache:warmup

# Let supervisord start nginx & php-fpm
ENTRYPOINT ["sh","-c","php-fpm -D && nginx -g 'daemon off;'"]
