#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y sudo apt git python-dev python-pip build-essential mono-complete openjdk-8-jdk

sudo dpkg --configure -a
pip install --upgrade pip

pip install virtualenv

mkdir -p /envs
chmod 777 /envs

virtualenv -p python2 /envs/judge

chmod 777 /envs/judge

source /envs/judge/bin/activate
pip install cython

cd /vagrant
git clone https://github.com/DMOJ/judge /vagrant/judge
cd judge
pip install -r requirements.txt

python setup.py develop

dmoj -c /vagrant/judge.yml -p 3000 192.168.43.115 
