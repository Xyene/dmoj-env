#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"

curl -sL https://deb.nodesource.com/setup_6.x | bash - >> $LOGS_FILE
apt-get install -y nodejs >> $LOGS_FILE
