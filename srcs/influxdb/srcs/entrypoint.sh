#!/bin/sh

#influxdの起動
/usr/sbin/influxd -config /etc/influxdb.conf &

#telegraf起動
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

tail -f /dev/null