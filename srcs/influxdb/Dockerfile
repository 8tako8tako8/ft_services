FROM alpine:3.13

RUN apk update \
    && apk add openrc \
    && apk add influxdb \
    && apk add libc6-compat \
    && apk add wget

#openrcの初期設定
RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

RUN mkdir -p /var/lib/influxdb

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