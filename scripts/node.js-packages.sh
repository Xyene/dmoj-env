#!/usr/bin/env bash

LOGS_FILE=$1/`basename "$0"`.log

if npm list -g --depth=0 | grep pleeease-cli then;
    echo -e "pleeease-cli is allready installed\n" >> $LOGS_FILE
else
    echo -e "pleeease-cli is not installed\n" >> $LOGS_FILE
    npm install -g pleeease-cli >> $LOGS_FILE
fi;

