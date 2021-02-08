#!/bin/sh

/grafana-7.3.7/bin/grafana-server --homepath grafana-7.3.7 &
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &

tail -f /dev/null