FROM alpine:3.20

# Install required packages

RUN apk update && \
    apk add \
    apache2-ssl apache2-ctl \
    php83 php83-apache2 \
    php83-ctype php83-curl php83-dom php83-fileinfo php83-gd php83-iconv php83-intl php83-json php83-mbstring php83-pdo_mysql php83-session php83-simplexml php83-tokenizer php83-xml php83-xmlreader php83-xmlwriter php83-zip \
    php83-pecl-xdebug \
    icu-data-full \
    composer \
    wait4ports \
    mariadb-client \
    curl \
    python3 py3-mysqlclient \
    tar bzip2 unzip

# Remap apache to port 8443

RUN sed -i -re "s/443/8443/gi" /etc/apache2/conf.d/ssl.conf 

# Enable elgg htaccess modifications 

RUN sed -i -re "s/AllowOverride None/AllowOverride All/gi" /etc/apache2/httpd.conf

# Enable rewrite module

RUN sed -i -re "s/^#LoadModule rewrite_module(.*)/LoadModule rewrite_module\1/gi" /etc/apache2/httpd.conf

# Enable xdebug

RUN rm /etc/php83/conf.d/*xdebug*
COPY xdebug.ini /etc/php83/xdebug.ini
COPY xdebugctl.sh /usr/local/bin
RUN chmod +x /usr/local/bin/xdebugctl.sh

# Copy php settings modifications

COPY zwabue.ini /etc/php83/conf.d/zwabue.ini

# Install entrypoint script

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 8443

ENTRYPOINT [ "/docker-entrypoint.sh" ]
