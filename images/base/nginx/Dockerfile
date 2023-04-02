FROM nginx:1.23.3-alpine AS base-nginx

RUN apk update && apk upgrade

WORKDIR /etc/nginx

# Create default directories
RUN mkdir -p ./conf.d/http/server ./conf.d/stream/server

# Copy the contents of the nginx directory
COPY ./nginx/ ./

# Set default environment variables
ENV NGINX_WORKER_PROCESSES=auto
