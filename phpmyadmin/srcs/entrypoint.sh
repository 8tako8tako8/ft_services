#!/bin/sh
#phpfpmの起動
rc-status
rc-service php-fpm7 start

#nginxの起動
nginx -g 'daemon off;'

#tail -f /dev/null