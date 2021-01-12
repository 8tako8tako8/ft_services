FROM alpine:latest

RUN apk update \
    && apk add openrc \
        nginx \
        openssl \
        openssh

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
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
#    -out /etc/ssl/certs/nginx-selfsigned.crt

#COPY ./default.conf /etc/nginx/conf.d/default.conf

#COPY ./srcs/default.conf /etc/nginx/conf.d/
COPY ./srcs/nginx.conf /etc/nginx/
COPY ./srcs/index.html /var/lib/nginx/html/
COPY ./srcs/sshd_config /etc/ssh/
COPY ./srcs/entrypoint.sh .
RUN chmod 744 /etc/nginx/nginx.conf \
    && chmod 744 /var/lib/nginx/html/index.html \
    && chmod 744 /etc/ssh/sshd_config \
    && chmod 744 ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]