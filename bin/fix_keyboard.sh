#!/bin/sh
xset r rate 450 21
xset -b

# Make caps:escape + ctrl!
setxkbmap -option "ctrl:nocaps"
xcape -e 'Control_L=Escape' -t 300

# Apply everything? Not sure what this is.
xmodmap ~/.Xmodmap
