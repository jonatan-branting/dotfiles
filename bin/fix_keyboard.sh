#!/bin/sh
echo "ENTERING KEYBOARD_FIX!"
setxkbmap -option caps:escape
xset r rate 450 21
xset -b
echo "LEAVING KEYBOARD FIX!"
