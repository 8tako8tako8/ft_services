#!/bin/sh
#grafana起動
/grafana-7.3.7/bin/grafana-server --homepath grafana-7.3.7 &
#telegraf起動
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

tail -f /dev/null