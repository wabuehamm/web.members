#!/usr/bin/env sh

echo "Recreating certificate"

printf "[dn]\nCN=web\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:web\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" > config

openssl req -x509 -out /etc/ssl/apache2/server.pem -keyout /etc/ssl/apache2/server.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj '/CN=web' -extensions EXT -config config

echo "Fixing permissions"

chown -R apache:apache /srv/elgg_data

echo "Starting web service"

/usr/sbin/httpd

tail -f /var/log/apache2/*.log
