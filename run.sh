#!/bin/bash

if [ ! -f /.root_pw_set ]; then
	sh /set_root_pw.sh
fi

rc-status
touch /run/openrc/softlevel
ssh-keygen -A

mkdir -p /root/.ssh/

echo "adding keys:"
echo $PUBLIC_SSH_KEYS

echo $PUBLIC_SSH_KEYS > /root/.ssh/authorized_keys

exec /usr/sbin/sshd -D
