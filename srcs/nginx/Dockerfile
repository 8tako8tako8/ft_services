FROM alpine:3.13

RUN apk update \
    && apk add openrc \
    && apk add nginx \
    && apk add openssl \
    && apk add openssh \
    && apk add libc6-compat

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

#ssh設定
RUN echo 'root:password' | chpasswd \
    && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
    && mkdir -p /var/run/sshd

#openssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=JP/ST=JAPAN/L=Tokyo/O=42tokyo/OU=Student/CN=localhost" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

#telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.2_linux_amd64.tar.gz \
    && tar xf telegraf-1.17.2_linux_amd64.tar.gz \
    && rm telegraf-1.17.2_linux_amd64.tar.gz \
    && mkdir -p /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf
RUN chmod 777 /etc/telegraf/telegraf.conf

COPY ./srcs/nginx.conf /etc/nginx/
RUN chmod 777 /etc/nginx/nginx.conf

COPY ./srcs/index.html /var/lib/nginx/html/
RUN chmod 777 /var/lib/nginx/html/index.html

COPY ./srcs/sshd_config /etc/ssh/
RUN chmod 777 /etc/ssh/sshd_config

COPY ./srcs/entrypoint.sh /
RUN chmod 777 /entrypoint.sh

COPY ./srcs/healthcheck.sh /
RUN chmod 777 /healthcheck.sh

ENTRYPOINT ["./entrypoint.sh"]