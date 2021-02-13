#!/bin/sh

#sshd起動
rc-status
rc-service sshd start

#telegraf起動
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

#nginx起動
nginx -g 'daemon off;'

tail -f /dev/null