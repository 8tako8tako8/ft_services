FROM alpine:latest

RUN apk update \
    && apk add openrc \
    && apk add openssl \
    && apk add vsftpd \
    && apk add lftp

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
RUN chmod 744 /etc/vsftpd/vsftpd.conf

COPY ./srcs/entrypoint.sh /
RUN chmod 744 /entrypoint.sh

EXPOSE 21 30000 30001

ENTRYPOINT ["./entrypoint.sh"]
