#! /bin/bash

FLOATING_DESKTOP_ID=$(bspc query -D -d '^9')

bspc subscribe node_manage | while read -a msg ; do
    desk_id=${msg[2]}
    wid=${msg[3]}
    bspc node "$wid" -t floating
done
