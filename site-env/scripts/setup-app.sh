#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"
SITE_DIR="$2"
VIRTUALENV_PATH="$3"

cd "$SITE_DIR"

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
} >> "$LOGS_FILE"

echo -e "Creating superuser!"

python manage.py createsuperuser >> "$LOGS_FILE" << EOF
$SUPERUSER_USERNAME
$SUPERUSER_EMAIL
$SUPERUSER_PWD
$SUPERUSER_RPT_PWD
EOF

echo -e "Superuser created!"
