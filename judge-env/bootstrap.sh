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


# Swift

wget https://swift.org/builds/swift-4.0-branch/ubuntu1604/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-08-04-a/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-08-04-a-ubuntu16.04.tar.gz -o /dev/null -O - | tar xzf - -C /tmp
mv /tmp/swift* /opt/swift4

sudo chown nobody /opt/swift4/usr/lib/swift/CoreFoundation/module.modulemap

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
