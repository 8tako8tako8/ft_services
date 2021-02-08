#!/bin/sh
#pgrepで見つからなければ終了ステータスで１となるのでどれか一つでも１であればコンテナ再起動させる
pgrep nginx
nginx=$?
pgrep php-fpm7
php-fpm7=$?
pgrep telegraf
telegraf=$?
if [ ${nginx} != 0 ] -o [ ${php-fpm7} != 0 ] -o [ ${telegraf} != 0 ]
then
    exit 1;
else
    exit 0
fi
