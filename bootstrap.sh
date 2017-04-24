#!/usr/bin/env bash

apt-get update
# apt-get install -y python-dev supervisor nginx git gcc g++ make python-dev libxml2-dev libxslt1-dev zlib1g-dev ruby-sass gettext curl

# wget -q --no-check-certificate -O- https://bootstrap.pypa.io/get-pip.py | sudo python
# wget -O- https://deb.nodesource.com/setup_7.x | sudo -E bash -
# apt-get update
# apt-get -y install nodejs
# dpkg --configure -a

# npm install -g pleeease-cli

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password vagrant"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password vagrant"
apt-get -y install mysql-server  libmysqlclient-dev

echo -e "\n--- Setting up our MySQL user and db ---\n"
mysql -uroot -pvagrant -e "CREATE DATABASE dmoj" 
mysql -uroot -pvagrant -e "grant all privileges on dmoj.* to 'vagrant'@'localhost' identified by 'vagrant'" 

sudo /etc/init.d/mysql restart

# wget -q --no-check-certificate -O- https://bootstrap.pypa.io/get-pip.py | sudo python

# pip install virtualenv

# mkdir -p /envs/dmoj
# virtualenv -p python /envs/dmoj

# source /envs/dmoj/bin/activate

if ! [ -L /var/www ]; then
    rm -rf /var/www
    ln -fs /vagrant /var/www
fi

# mkdir -p /vagrant/dmoj

# git clone https://github.com/Minkov/site.git /vagrant/dmoj/site
# cd /vagrant/dmoj/site
# git submodule init
# git submodule update
# cd -

