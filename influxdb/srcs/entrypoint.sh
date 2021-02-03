#!/bin/sh

/usr/sbin/influxd -config /etc/influxdb.conf &
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf

#tail -f /dev/null