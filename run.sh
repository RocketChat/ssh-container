#!/bin/sh

if [ ! -f /.root_pw_set ]; then
	sh /set_root_pw.sh
fi

rc-status
touch /run/openrc/softlevel
ssh-keygen -A

if [ "${PUBLIC_SSH_KEYS}" != "**None**" ]; then
	echo "=> Found authorized keys"

	# Create SSH files on container
	mkdir -p /root/.ssh
	chmod 700 /root/.ssh
	touch /root/.ssh/authorized_keys
	chmod 600 /root/.ssh/authorized_keys

	# Create SSH files on node
	mkdir -p /user/.ssh
	chmod 700 /user/.ssh
	touch /user/.ssh/authorized_keys
	chmod 600 /user/.ssh/authorized_keys

	IFS=$'\n'
	arr=$(echo ${PUBLIC_SSH_KEYS} | tr "," "\n")
	for x in $arr
	do
		x=$(echo $x | sed -e 's/^ *//' -e 's/ *$//')
		cat /user/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "=> Adding public key to .ssh/authorized_keys: $x"
			echo "$x" >> /user/.ssh/authorized_keys
		fi
		echo "$x" >> /root/.ssh/authorized_keys
	done

	exec /usr/sbin/sshd -D
else
	echo "ERROR: No authorized keys found in \$PUBLIC_SSH_KEYS"
	exit 1
fi
