#!/bin/sh
setxkbmap -option caps:escape
xset r rate 450 21
xset -b
xmodmap ~/.Xmodmap
