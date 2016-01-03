#!/bin/bash
# /etc/init.d/first_boot_script.sh

### BEGIN INIT INFO
# Provides:          servoblaster
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Example initscript
# Description:       This service is used to manage a servo
### END INIT INFO

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
      /data/core/init/rpi-wiggle-full-automation > /dev/null 2>&1
      rm $0 > /dev/null 2>&1
    ;;
  *)
    echo "Usage: $0 start" >&2
    exit 3
    ;;
esac
