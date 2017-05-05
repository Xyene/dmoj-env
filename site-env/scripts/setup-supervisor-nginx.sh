#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

FILES_DIR=$2

touch /vagrant/bridge.log
chmod 777 /vagrant/bridge.log

cp $FILES_DIR/site.conf /etc/supervisor/conf.d/site.conf >> "$LOGS_FILE"
cp $FILES_DIR/bridged.conf /etc/supervisor/conf.d/bridged.conf >> "$LOGS_FILE"
cp $FILES_DIR/nginx.conf /etc/nginx/conf.d/nginx.conf >> "$LOGS_FILE"

sudo systemctl restart supervisor >> "$LOGS_FILE"
sudo systemctl reload-or-restart nginx >> "$LOGS_FILE"

