#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log
SITE_DIR=$2
cd $SITE_DIR

source /envs/dmoj/bin/activate
pip install -r requirements.txt >> "$LOGS_FILE"
pip install mysqlclient >> "$LOGS_FILE"
python manage.py check >> "$LOGS_FILE"
python manage.py migrate >> "$LOGS_FILE"
./make_style.sh >> "$LOGS_FILE"
echo "yes" | python manage.py collectstatic >> "$LOGS_FILE"
python manage.py compilemessages >> "$LOGS_FILE"
python manage.py compilejsi18n >> "$LOGS_FILE"
python manage.py loaddata navbar >> "$LOGS_FILE"
python manage.py loaddata language_small >> "$LOGS_FILE"
