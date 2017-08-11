#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"
VIRTUALENV_PATH="$2"

exec >> "$LOGS_FILE"

pip install virtualenv
rm -rf "$VIRTUALENV_PATH"
mkdir -p "$VIRTUALENV_PATH"

virtualenv -p python "$VIRTUALENV_PATH"
# source /envs/dmoj/bin/activate >> "$LOGS_FILE"
