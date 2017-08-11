#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"
FILES_DIR="$2"

exec >> "$LOGS_FILE"

touch /vagrant/bridge.log
chmod 666 /vagrant/bridge.log

cp $FILES_DIR/site.conf /etc/supervisor/conf.d/site.conf
cp $FILES_DIR/bridged.conf /etc/supervisor/conf.d/bridged.conf
cp $FILES_DIR/nginx.conf /etc/nginx/conf.d/nginx.conf

systemctl restart supervisor
systemctl reload-or-restart nginx
