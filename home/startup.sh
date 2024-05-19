#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/ccc/.Xauthority

sleep 5

sudo killall chromium-browser
pulseaudio -k
pulseaudio --start

sleep 15

echo "$(date): Starting Barrier and Chromium" > ~/startup.log
barrierc -f --disable-crypto 192.168.50.127 >> ~/startup.log 2>&1 &
echo "$(date): Started Barrier" >> ~/startup.log
/usr/bin/chromium-browser --profile-directory=Default --app-id=pjibgclleladliembfgfagdaldikeohf >> ~/startup.log 2>&1 &
echo "$(date): Started Chromium" >> ~/startup.log
