#!/usr/bin/env bash

echo -e "\n --- Find all logs in /vagrant/logs ---\n"
LOGS_DIR=/vagrant/logs
rm -r $LOGS_DIR
mkdir -p $LOGS_DIR

echo -e "\n --- Installing apt-get dependendies ---\n"
sh /vagrant/scripts/dependendies.sh $LOGS_DIR

echo -e "\n --- Installing Node.js ---\n"
sh /vagrant/scripts/node.js.sh $LOGS_DIR

echo -e "\n --- Installing Node.js packages ---\n"
sh /vagrant/scripts/node.js-packages.sh $LOGS_DIR 

echo -e "\n --- Installing and Setting up MySQL ---\n"
sh /vagrant/scripts/mysql.sh $LOGS_DIR

DMOJ_DIR=/vagrant/dmoj
SITE_DIR=$DMOJ_DIR/site
FILES_DIR=/vagrant/files

sh /vagrant/scripts/virtualenv-setup.sh $LOGS_DIR

echo -e "\n --- Checkout web app --- \n"
sh /vagrant/scripts/checkout-app.sh $LOGS_DIR $SITE_DIR

echo -e "\n --- Setup web app ---\n"
sh /vagrant/scripts/setup-app.sh $LOGS_DIR $SITE_DIR


mkdir -p /vagrant/files
cd /vagrant/files

curl http://uwsgi.it/install | bash -s default $PWD/uwsgi >> $LOGS_DIR/uwsgi.log

echo -e "\n --- Setup Supervisor and nginx ---\n"
sh /vagrant/scripts/setup-supervisor-nginx.sh $LOGS_DIR $FILES_DIR
