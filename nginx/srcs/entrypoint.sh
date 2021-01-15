#!/bin/sh

rc-status
rc-service sshd start

nginx -g 'daemon off;'

#tail -f /dev/null