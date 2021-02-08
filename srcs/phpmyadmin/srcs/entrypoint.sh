#!/bin/sh
#phpfpmの起動
rc-status
rc-service php-fpm7 start
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

#nginxの起動
nginx -g 'daemon off;'

tail -f /dev/null