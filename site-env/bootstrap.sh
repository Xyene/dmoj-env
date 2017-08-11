#!/usr/bin/env bash

echo -e "\n --- Find all logs in /vagrant/logs ---\n"
LOGS_DIR=/vagrant/logs
rm -r $LOGS_DIR
mkdir -p $LOGS_DIR

echo -e "\n --- Installing apt-get dependendies ---\n"
bash /vagrant/scripts/dependendies.sh $LOGS_DIR

echo -e "\n --- Installing Node.js ---\n"
bash /vagrant/scripts/node.js.sh $LOGS_DIR

echo -e "\n --- Installing Node.js packages ---\n"
bash /vagrant/scripts/node.js-packages.sh $LOGS_DIR

echo -e "\n --- Installing and Setting up MySQL ---\n"
bash /vagrant/scripts/mysql.sh $LOGS_DIR

DMOJ_DIR=/vagrant/dmoj
SITE_DIR=$DMOJ_DIR/site
FILES_DIR=/vagrant/files
VIRTUALENV_PATH=/envs/dmoj

adduser dmoj

echo -e "\n --- Setup virtualenv ---\n"
bash /vagrant/scripts/virtualenv-setup.sh $LOGS_DIR $VIRTUALENV_PATH

sudo chown -R vagrant:vagrant $VIRTUALENV_PATH

source $VIRTUALENV_PATH/bin/activate

echo -e "\n --- Checkout web app --- \n"
bash /vagrant/scripts/checkout-app.sh $LOGS_DIR $SITE_DIR


echo -e "\n --- Setup web app ---\n"
bash /vagrant/scripts/setup-app.sh $LOGS_DIR $SITE_DIR

mkdir -p /vagrant/files
cd /vagrant/files

curl http://uwsgi.it/install | bash -s default $PWD/uwsgi >> $LOGS_DIR/uwsgi.log

echo -e "\n --- Setup Supervisor and nginx ---\n"
bash /vagrant/scripts/setup-supervisor-nginx.sh $LOGS_DIR $FILES_DIR
