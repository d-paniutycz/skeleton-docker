ARG PHAR_DIR=/usr/local/lib

FROM php:8.2.4-cli-alpine3.17 AS phive-builder

ARG PHAR_DIR
WORKDIR ${PHAR_DIR}

# Install PHIVE
RUN set -eux && \
    wget -O phive.phar https://phar.io/releases/phive.phar && \
    wget -O phive.phar.asc https://phar.io/releases/phive.phar.asc && \
    apk add --no-cache gnupg && \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys 0x9D8A98B29B2D5D79 && \
    gpg --batch --verify phive.phar.asc phive.phar && \
    rm phive.phar.asc && \
    chmod +x phive.phar && \
    mv phive.phar /usr/local/bin/phive

# Copy configuration
COPY ./.phive/ ./.phive/

# Install PHARs
RUN phive \
    --no-progress install \
    --trust-gpg-keys CBB3D576F2A0946F,CF1A108D0E7AE720,12CE0F1D262429A5,A4E55EA12C7C085C,31C7E470E2138192 \
    --copy

FROM alpine:3.17 AS base-toolbox

ARG PHAR_DIR
WORKDIR ${PHAR_DIR}

# Copy tools
COPY --from=phive-builder ${PHAR_DIR}/utility/ ./utility/
COPY --from=phive-builder ${PHAR_DIR}/quality/ ./quality/
