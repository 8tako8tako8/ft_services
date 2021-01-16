#!/bin/sh
#mysql_install_db --user=mysql --datadir=/var/lib/mysql
#rc-status
#rc-service mariadb start
#mysqladmin -u root password toor
#echo "CREATE DATABASE wpdb;"| mysql -u root --skip-password
#echo "CREATE USER 'test'@'%' identified by 'password';"| mysql -u root --skip-password
#echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'test'@'%';"| mysql -u root --skip-password
#echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

#/etc/init.d/mariadb setup
#rc-service mariadb start
#mysql -e "CREATE DATABASE wpdb;"
#mysql -e "CREATE USER 'test'@'%' identified by 'password';"
#mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'test'@'%';"
#mysql -e "FLUSH PRIVILEGES;"

tail -f /dev/null