#!/usr/bin/env bash
LOGS_FILE=$1/`basename "$0"`.log

SITE_DIR=$2

git clone https://github.com/Minkov/site.git $SITE_DIR >> "$LOGS_FILE"
cd $SITE_DIR
git pull  >> "$LOGS_FILE"
git submodule init  >> "$LOGS_FILE"
git submodule update  >> "$LOGS_FILE"
