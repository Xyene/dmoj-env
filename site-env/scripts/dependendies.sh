#!/usr/bin/env bash
LOGS_FILE=$1/`basename "$0"`.log

apt-get update >> "$LOGS_FILE"

apt-get install -y supervisor nginx git gcc g++ make python-dev python-pip libxml2-dev libxslt1-dev zlib1g-dev ruby-sass gettext curl   >> "$LOGS_FILE"
pip install --upgrade pip

