#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

pip install virtualenv >> "$LOGS_FILE"
mkdir -p /envs/dmoj >> "$LOGS_FILE"
virtualenv -p python /envs/dmoj >> "$LOGS_FILE"
source /envs/dmoj/bin/activate >> "$LOGS_FILE"

