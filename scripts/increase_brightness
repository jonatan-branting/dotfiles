#!/bin/sh
BRIGHTNESS_BEFORE=$(xbacklight -get | cut -d "." -f 1)

if [ $BRIGHTNESS_BEFORE -ne 100 ]
  then
    xbacklight +5 -steps 1 -time 0
    BRIGHTNESS_NEW=$(xbacklight -get | cut -d "." -f 1)
    notify-send -h "int:value:$BRIGHTNESS_NEW" "Backlight" "Brightness:"
fi

