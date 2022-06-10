#!/bin/sh
set -e

groupadd -g ${GROUP_ID} ${HOST_USER}
useradd -g ${GROUP_ID} -u ${USER_ID} -s /bin/bash -m ${HOST_USER}
usermod -a -G wheel ${HOST_USER}
echo "%wheel  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers
echo "export PATH=/usr/local/bin:$PATH" > /etc/bashrc

exec /usr/local/bin/dockerd-entrypoint.sh $@
