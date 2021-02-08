#!/bin/sh

/etc/init.d/mariadb setup
rc-status
rc-service mariadb start
mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER 'admin'@'%' identified by 'admin';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"
rc-status
rc-update add mariadb
/etc/init.d/mariadb restart
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

tail -f /dev/null