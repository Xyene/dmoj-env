#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y sudo apt git python-dev python-pip build-essential mono-complete openjdk-8-jdk ruby php ghc \
    clang libicu-dev 

wget -q -O - https://swift.org/keys/all-keys.asc | \
  gpg --import -

pip install --upgrade pip

pip install setuptools
pip install cython

cd /vagrant
git clone https://github.com/minkov/judge /vagrant/judge
cd judge
pip install -r requirements.txt

python setup.py develop

git clone https://github.com/cuklev/dsa-miniexam-tasks-dmoj.git /problems

cp /vagrant/systemd_files/* /etc/systemd/system/

for cmd in enable start; do
	for unit in dmoj-judge@WorkPcDoncho{1..3}.service dmoj-sync-problems.timer; do
		systemctl $cmd $unit
	done
done
