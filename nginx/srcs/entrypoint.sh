#!/bin/sh

rc-status
rc-service sshd start

#rc-service nginx start
nginx -g 'daemon off;'

#tail -f /dev/null