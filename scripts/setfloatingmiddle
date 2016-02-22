#!/bin/bash
WIN_WIDTH=920
SCREEN_WIDTH=$(xdpyinfo | grep 'dimensions:' | cut -f 7 -d " " | cut -f 1 -dx)
SCREEN_CENTER=$(bc <<< "$SCREEN_WIDTH/2")
SX=$(bc <<< "$SCREEN_CENTER - $WIN_WIDTH/2")
echo $SCREEN_WIDTH
echo $SCREEN_CENTER
echo $SX
wmctrl -ir $(xdotool getactivewindow) -e 0,$SX,20,$WIN_WIDTH,1040
bspc window -t floating
