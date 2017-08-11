#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"

exec >> "$LOGS_FILE"

curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get install -y nodejs
