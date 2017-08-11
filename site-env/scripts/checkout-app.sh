#!/bin/bash

LOGS_FILE="$1/$(basename "$0").log"
SITE_DIR="$2"

exec >> "$LOGS_FILE"

git clone https://github.com/Minkov/site.git "$SITE_DIR"
cd "$SITE_DIR"
git pull
git submodule init
git submodule update
