#!/bin/sh
xset r rate 300 30
xset -b

# Apply modified layout
setxkbmap -option "ctrl:nocaps"
xmodmap ~/.Xmodmap

# Make Control (Caps Lock ) into Control + Escape!
xcape -e 'Control_L=Escape' -t 300
