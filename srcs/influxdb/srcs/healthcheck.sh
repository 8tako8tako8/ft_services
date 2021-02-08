#!/bin/sh
#pgrepで見つからなければ終了ステータスで１となるのでどれか一つでも１であればコンテナ再起動させる
pgrep influxd
influxd=$?
pgrep telegraf
telegraf=$?
if [ ${influxd} != 0 ] -o [ ${telegraf} != 0 ]
then
    exit 1;
else
    exit 0
fi
