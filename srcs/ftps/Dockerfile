FROM alpine:3.13

RUN apk update \
    && apk add openrc \
    && apk add openssl \
    && apk add libc6-compat \
    && apk add vsftpd \
    && apk add lftp

#openrc
RUN sed -i'.bak' 's/^#rc_sys=""/rc_sys="lxc"/' /etc/rc.conf \
    && sed -i 's/^#rc_provide="!net"/rc_provide="loopback net"/' /etc/rc.conf \
    && sed -i'.bak' '/getty/d' /etc/inittab \
    && sed -i'.bak' 's/mount -t tmpfs/# mount -t tmpfs/' /lib/rc/sh/init.sh \
    && sed -i'.bak' 's/hostname $opts/# hostname $opts/' /etc/init.d/hostname \
    && sed -i'.bak' 's/cgroup_add_service$/# cgroup_add_service/' /lib/rc/sh/openrc-run.sh \
    && mkdir /run/openrc \
    && touch /run/openrc/softlevel

RUN adduser -D kmorimot \
    && echo "kmorimot:password" | chpasswd

#openssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=JP/ST=JAPAN/L=Tokyo/O=42tokyo/OU=Student/CN=localhost" \
    -newkey rsa:2048 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN chmod 777 /etc/vsftpd/vsftpd.conf

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
