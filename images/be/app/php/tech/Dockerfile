FROM ghcr.io/d-paniutycz/skeleton-docker/base/php/fpm:1.2 AS be-app-php-tech

# Copy phars from phar library
COPY --from=ghcr.io/d-paniutycz/skeleton-docker/base/lib/phar:1.1 /usr/local/lib/utility/ /usr/local/bin/
COPY --from=ghcr.io/d-paniutycz/skeleton-docker/base/lib/phar:1.1 /usr/local/lib/quality/ /usr/local/bin/

# Install php extensions
RUN install-php-extensions xdebug

WORKDIR $PHP_INI_DIR

COPY ./conf.d/ ./conf.d/
