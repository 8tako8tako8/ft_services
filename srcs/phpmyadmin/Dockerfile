FROM alpine:3.13

RUN apk update \
    && apk add openrc \
    && apk add openssl \
    && apk add nginx \
    && apk add php7-fpm php7-session php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-mbstring \
    && apk add wget \
    && apk add libc6-compat

RUN mkdir ーp /run/nginx

#openrc
RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

RUN adduser -D -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www

#phpmyadminダウンロード
RUN cd /www/ \
    && wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz \
    && tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz \
    && rm phpMyAdmin-5.0.2-all-languages.tar.gz \
    && mv phpMyAdmin-5.0.2-all-languages phpmyadmin \
    && chown -R www /www/phpmyadmin \
    && mkdir /www/phpmyadmin/tmp \
    && chmod 777 /www/phpmyadmin/tmp
#openssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=JP/ST=JAPAN/L=Tokyo/O=42tokyo/OU=Student/CN=localhost" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

COPY ./srcs/config.inc.php /www/phpmyadmin/
RUN chmod 644 /www/phpmyadmin/config.inc.php

COPY ./srcs/nginx.conf /etc/nginx/
RUN chmod 777 /etc/nginx/nginx.conf

#telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
    && tar xf telegraf-1.17.2_linux_amd64.tar.gz \
    && rm telegraf-1.17.2_linux_amd64.tar.gz \
    && mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

COPY ./srcs/healthcheck.sh /
RUN chmod 777 /healthcheck.sh

COPY ./srcs/entrypoint.sh /
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]