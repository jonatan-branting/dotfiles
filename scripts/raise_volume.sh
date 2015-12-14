#!/bin/sh
VOL_BEFORE=$(amixer -c 0 sget Master | grep % | awk '{ print $4}' | sed -e 's/[]*%*[*]//g')

if [ $VOL_BEFORE -ne 100 ]
  then
    amixer -q -c 0 -- sset Master playback 2+ unmute
    VOL_NEW=$(amixer -c 0 sget Master | grep % | awk '{ print $4}' | sed -e 's/[]*%*[*]//g')
    notify-send -h "int:value:$VOL_NEW" "Volume" "Master: "
fi

