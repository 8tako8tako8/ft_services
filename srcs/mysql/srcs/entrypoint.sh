#!/bin/sh

#database作成
/etc/init.d/mariadb setup
rc-status
rc-service mariadb start
mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER 'admin'@'%' identified by 'admin';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysql -u root < create_tables.sql
mysql -e "CREATE USER 'pma'@'%' identified by 'pmapasssss';"
mysql -e "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'pma'@'%';"
mysql -e "FLUSH PRIVILEGES;"
rc-service mariadb stop

#telegraf起動
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

#mysqld起動
/usr/bin/mysqld --user=mysql --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --pid-file=/run/mysqld/mariadb.pid

tail -f /dev/null