#!/usr/bin/env bash

LOGS_DIR="/vagrant/logs"
echo -e "\n --- Find all logs in $LOGS_DIR ---\n"
rm -rf "$LOGS_DIR"
mkdir -p "$LOGS_DIR"

echo -e "\n --- Installing apt-get dependendies ---\n"
{
	apt-get update
	apt-get install -y supervisor nginx git gcc g++ make python-dev python-pip libxml2-dev libxslt1-dev zlib1g-dev ruby-sass gettext curl

	pip install --upgrade pip
} >> "$LOGS_DIR/dependencies.log"

echo -e "\n --- Installing Node.js ---\n"
{
	curl -sL https://deb.nodesource.com/setup_6.x | bash -
	apt-get install -y nodejs
} >> "$LOGS_DIR/node.js.log"

echo -e "\n --- Installing Node.js packages ---\n"
function npm_package_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  npm list -g --depth=0 | grep $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

{
	if [ $(npm_package_is_installed pleeease-cli) = 1 ]; then
		echo -e "pleeease-cli is already installed\n"
	else
		echo -e "pleeease-cli is not installed\n"
		npm install -g pleeease-cli
	fi
} >> "$LOGS_DIR/node.js-packages.log"

echo -e "\n --- Installing and Setting up MySQL ---\n"
{
	echo "mysql-server mysql-server/root_password password vagrant"       | debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password vagrant" | debconf-set-selections

	apt-get -y install mysql-server libmysqlclient-dev

# echo -e "\n--- Setting up our MySQL user and db ---\n"
	mysql -uroot -pvagrant -e "CREATE DATABASE dmoj"
	mysql -uroot -pvagrant -e "grant all privileges on dmoj.* to 'vagrant'@'localhost' identified by 'vagrant'"

	systemctl restart mysql
} >> "$LOGS_DIR/mysql.log"

DMOJ_DIR=/vagrant/dmoj
SITE_DIR=$DMOJ_DIR/site
FILES_DIR=/vagrant/files
VIRTUALENV_PATH=/envs/dmoj

adduser dmoj

echo -e "\n --- Setup virtualenv ---\n"
{
	pip install virtualenv
	rm -rf "$VIRTUALENV_PATH"
	mkdir -p "$VIRTUALENV_PATH"

	virtualenv -p python "$VIRTUALENV_PATH"

	chown -R vagrant:vagrant "$VIRTUALENV_PATH"
} >> "$LOGS_DIR/virtualenv-setup.log"

echo -e "\n --- Checkout web app --- \n"
{
	git clone https://github.com/Minkov/site.git "$SITE_DIR"
	cd "$SITE_DIR"
	git pull
	git submodule init
	git submodule update
} >> "$LOGS_DIR/checkout-app.log"

echo -e "\n --- Setup web app ---\n"
source "$VIRTUALENV_PATH/bin/activate"

{
	npm install

	pip install -r requirements.txt
	pip install mysqlclient
	pip install websocket-client

	python manage.py check
	python manage.py migrate

	./make_style.sh

	echo "yes" | python manage.py collectstatic
	python manage.py compilemessages
	python manage.py compilejsi18n
	python manage.py loaddata navbar
	python manage.py loaddata language_small

	python manage.py createsuperuser << EOF
$SUPERUSER_USERNAME
$SUPERUSER_EMAIL
$SUPERUSER_PWD
$SUPERUSER_RPT_PWD
EOF
} >> "$LOGS_DIR/setup-app.log"

echo -e "Superuser created!"

mkdir -p /vagrant/files
cd /vagrant/files

curl http://uwsgi.it/install | bash -s default "$PWD/uwsgi" >> "$LOGS_DIR/uwsgi.log"

echo -e "\n --- Setup Supervisor and nginx ---\n"
{
	touch /vagrant/bridge.log
	chmod 666 /vagrant/bridge.log

	cp $FILES_DIR/site.conf /etc/supervisor/conf.d/site.conf
	cp $FILES_DIR/bridged.conf /etc/supervisor/conf.d/bridged.conf
	cp $FILES_DIR/nginx.conf /etc/nginx/conf.d/nginx.conf

	systemctl restart supervisor
	systemctl restart nginx
} >> "$LOGS_FILE/setup-supervisor-nginx.log"
