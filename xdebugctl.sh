#!/usr/bin/env sh

if [ $# -ne 1 ]
then
    echo "Usage: xdebugctl.sh on/off"
fi

ACTION=$1

if [ "X${ACTION}X" == "XonX" ]
then
    cp /etc/php7/xdebug.ini /etc/php7/conf.d/xdebug.ini
    apachectl graceful
else
    rm /etc/php7/conf.d/xdebug.ini
    apachectl graceful
fi