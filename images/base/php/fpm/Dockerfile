FROM php:8.2.4-fpm-alpine3.17 AS base-php-fpm

RUN apk update && apk upgrade

WORKDIR /usr/local/etc/php

# Copy php extension installer
COPY --from=mlocati/php-extension-installer:2.1.10 /usr/bin/install-php-extensions /usr/local/bin/

# Install php extensions
RUN install-php-extensions pdo_pgsql intl

# Install packages
RUN apk add --no-cache bash
