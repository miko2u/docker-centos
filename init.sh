#!/bin/bash

# remove unused services
rm -f /sbin/initctl /etc/rc0.d/S01halt /etc/rc6.d/S01reboot

# additional startup
if [ -x /boot/prepare ]; then
    /boot/prepare
fi

# startup
/etc/rc.d/rc 3

# additional startup
if [ -x /boot/post ]; then
    /boot/post
fi

# shutdown signal
echo "trap '/etc/rc.d/rc 0; exit 0' TERM" >> ~/.bashrc
exec /bin/bash
