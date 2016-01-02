#!/bin/bash

. /lib/lsb/init-functions

set -e

case "$1" in
  start)
 nohup sh -c "yes | ssh-keygen -q -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key && \
      yes | ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key && \
      yes | ssh-keygen -q -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
      update-rc.d ssh enable && sync && \
      invoke-rc.d ssh start && \
      rm -f /home/paranoid/.ssh/known_hosts && \
      rm -f /root/.ssh/known_hosts && \
      rm -f /home/paranoid/.bash_history && \
      rm -f /root/.bash_history" > /dev/null 2>&1
      for i in `find /var/log -type f`;do echo '' > $i;done; > /dev/null 2>&1
      /data/core/init/rpi-wiggle-full-automation
      rm $0 > /dev/null 2>&1
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
    ;;
esac
