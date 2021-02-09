FROM alpine:latest

RUN apk update \
    && apk add openrc \
    && apk add openssl \
    && apk add libc6-compat \
    && apk add wget \
    && apk add vsftpd \
    && apk add lftp

#openrcの初期設定
RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

#grafana
RUN wget https://dl.grafana.com/oss/release/grafana-7.3.7.linux-amd64.tar.gz
RUN tar -zxvf grafana-7.3.7.linux-amd64.tar.gz
RUN rm grafana-7.3.7.linux-amd64.tar.gz

#telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz
RUN tar xf telegraf-1.17.2_linux_amd64.tar.gz
RUN rm telegraf-1.17.2_linux_amd64.tar.gz
RUN mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

RUN adduser -D kmorimot \
    && echo "kmorimot:password" | chpasswd

#openssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=JP/ST=JAPAN/L=Tokyo/O=42tokyo/OU=Student/CN=localhost" \
    -newkey rsa:2048 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

#COPY ./srcs/grafana.db /grafana-7.3.7/data/

COPY ./srcs/datasources/* /grafana-7.3.7/conf/provisioning/datasources/
COPY ./srcs/dashboards/* /grafana-7.3.7/conf/provisioning/dashboards/

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

#COPY ./srcs/healthcheck.sh /
#RUN chmod 777 /healthcheck.sh

COPY ./srcs/entrypoint.sh /
RUN chmod 744 /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]