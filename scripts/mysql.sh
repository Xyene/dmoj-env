#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password vagrant"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password vagrant"
apt-get -y install mysql-server  libmysqlclient-dev >> "$LOGS_FILE" 

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -pvagrant -e "CREATE DATABASE dmoj" >> "$LOGS_FILE" 
mysql -uroot -pvagrant -e "grant all privileges on dmoj.* to 'vagrant'@'localhost' identified by 'vagrant'" >> "$LOGS_FILE" 

sudo systemctl restart mysql >> "$LOGS_FILE"
