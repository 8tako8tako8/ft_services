#!/bin/sh
#phpfpmの起動
rc-status
rc-service php-fpm7 start

#wp-cliインストール
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
while true
do
    wp core install --url=https://192.168.49.200:5050 --title=test --admin_user=admin --admin_password=admin --admin_email=test@example.com --path=/www/wordpress && break
    sleep 10
done
wp user create kmorimot kmorimot@example.com --display_name="kmorimot" --role=editor --user_pass="kmorimot" --path=/www/wordpress
wp user create john john@example.com --display_name="john" --role=editor --user_pass="john" --path=/www/wordpress
wp user create kao kao@example.com --display_name="kao" --role=author --user_pass="kao" --path=/www/wordpress

#telegraf起動
/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

#nginxの起動
nginx -g 'daemon off;'

tail -f /dev/null