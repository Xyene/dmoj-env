#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> $LOGS_FILE
sudo apt-get install -y nodejs >> $LOGS_FILE
