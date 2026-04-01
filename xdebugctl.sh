#!/usr/bin/env sh

if [ $# -ne 1 ]
then
    echo "Usage: xdebugctl.sh on/off"
fi

ACTION=$1

if [ "X${ACTION}X" == "XonX" ]
then
    cp /etc/php83/xdebug.ini /etc/php83/conf.d/xdebug.ini
    apachectl graceful
else
    rm /etc/php83/conf.d/xdebug.ini
    apachectl graceful
fi