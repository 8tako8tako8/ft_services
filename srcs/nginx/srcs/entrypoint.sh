#!/bin/sh

rc-status
rc-service sshd start
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
nginx -g 'daemon off;'

tail -f /dev/null