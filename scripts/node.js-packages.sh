#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

npm install -g pleeease-cli >> $LOGS_FILE

