FROM alpine:latest

RUN apk update \
    && apk add openrc \
    && apk add nginx \
    && apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype \
    && apk add wget

#mkdirしないとdaemon offでエラー出る
RUN mkdir ーp /run/nginx

#openrcの初期設定
RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel \
    && sed -i'.bak' 's/return 404;/root html;\n\t\tindex index.html;/' /etc/nginx/conf.d/default.conf

RUN adduser -D -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www

COPY ./srcs/nginx.conf /etc/nginx/
RUN chmod 744 /etc/nginx/nginx.conf

RUN cd /www/ \
    && wget http://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && rm latest.tar.gz \
    && chown -R www /www/wordpress

COPY ./srcs/wp-config.php /www/wordpress/
RUN chmod 744 /www/wordpress/wp-config.php

RUN apk update \
    && apk add mysql mysql-client

COPY ./srcs/entrypoint.sh /
RUN chmod 744 /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]