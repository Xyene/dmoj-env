#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y sudo apt git python-dev python-pip build-essential mono-complete openjdk-8-jdk ruby php ghc \
    clang libicu-dev

pip install --upgrade pip

pip install setuptools
pip install cython

# Swift

wget https://swift.org/builds/swift-4.0-branch/ubuntu1604/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-08-04-a/swift-4.0-DEVELOPMENT-SNAPSHOT-2017-08-04-a-ubuntu16.04.tar.gz -o /dev/null -O - | tar xzf - -C /tmp
mv /tmp/swift* /opt/swift4

chown nobody /opt/swift4/usr/lib/swift/CoreFoundation/module.modulemap

cd /vagrant
if [[ -f v8dmoj_bin.tar.xz ]]; then
	echo "v8dmoj found :)"
	cp -r v8dmoj_bin /opt
else
	echo "v8dmoj not found! You must build it first."
fi

git clone https://github.com/minkov/judge /vagrant/judge
cd /vagrant/judge

pip install -r requirements.txt

python setup.py develop

git clone https://github.com/cuklev/dsa-miniexam-tasks-dmoj.git /problems

cp /vagrant/systemd_files/* /etc/systemd/system/

for cmd in enable start; do
    for unit in dmoj-judge@AwsJudge{1..3}.service dmoj-sync-problems.timer; do
		systemctl $cmd $unit
	done
done
