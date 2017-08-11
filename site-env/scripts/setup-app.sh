#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"
SITE_DIR="$2"

cd "$SITE_DIR"

{
	npm install

	# source /envs/dmoj/bin/activate
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
} >> "$LOGS_FILE"

echo -e "Creating superuser!"

echo -e "$SUPERUSER_USERNAME\n$SUPERUSER_EMAIL\n$SUPERUSER_PWD\n$SUPERUSER_RPT_PWD" | python manage.py createsuperuser

echo -e "Superuser created!"
