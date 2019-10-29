#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
    xbacklight -get | cut -d "." -f 1
}

function send_notification {
    brightness=$(get_brightness)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($brightness / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -a local -t 700 -r 2593 -u normal "brt:" " $bar"
}

case $1 in
    up)
	# Up the volume (+ 5%)
	xbacklight +5 -steps 1 -time 0.001 > /dev/null
	send_notification
	;;
    down)
	xbacklight -5 -steps 1 -time 0.001 > /dev/null
	send_notification
	;;
esac
