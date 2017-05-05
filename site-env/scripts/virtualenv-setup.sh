#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

VIRTUALENV_PATH="$2"

pip install virtualenv >> "$LOGS_FILE"
rm -r "$VIRTUALENV_PATH" >> "$LOGS_FILE"
mkdir -p "$VIRTUALENV_PATH" >> "$LOGS_FILE"

virtualenv -p python "$VIRTUALENV_PATH" >> "$LOGS_FILE"
# source /envs/dmoj/bin/activate >> "$LOGS_FILE"

