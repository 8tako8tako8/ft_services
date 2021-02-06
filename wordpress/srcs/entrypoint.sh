#!/bin/sh
#phpfpmの起動
rc-status
rc-service php-fpm7 start

#wp-cliインストール
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp core install --url=https://10.0.2.15:5050 --title=test --admin_user=admin --admin_password=password --admin_email=test@example.com --path=/www/wordpress
wp user create kmorimot kmorimot@example.com --display_name="kmorimot" --role=editor --user_pass="password" --path=/www/wordpress
wp user create john john@example.com --display_name="john" --role=editor --user_pass="password" --path=/www/wordpress
wp user create kao kao@example.com --display_name="kao" --role=author --user_pass="password" --path=/www/wordpress

/telegraf-1.17.2/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &

#nginxの起動
nginx -g 'daemon off;'