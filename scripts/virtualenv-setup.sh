#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

pip install virtualenv >> "$LOGS_FILE"
rm -r /envs/dmoj
mkdir -p /envs/dmoj >> "$LOGS_FILE"

sudo chown -R vagrant:vagrant /envs

virtualenv -p python /envs/dmoj >> "$LOGS_FILE"
# source /envs/dmoj/bin/activate >> "$LOGS_FILE"

