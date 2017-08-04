#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y sudo apt git python-dev python-pip build-essential mono-complete openjdk-8-jdk

pip install --upgrade pip

pip install setuptools
pip install cython

cd /vagrant
git clone https://github.com/DMOJ/judge /vagrant/judge
cd judge
pip install -r requirements.txt

python setup.py develop

mkdir /problems

git clone https://github.com/cuklev/dsa-miniexam-tasks-dmoj.git /problems

dmoj -c /vagrant/judge.yml "52.28.196.151" WorkPc 1234567890
