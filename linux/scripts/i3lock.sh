#!/usr/bin/env bash

if [[ ! -f /tmp/lockcache ]]; then
	convert ~/.wallpaper ~/.lockscreen \
		-gravity center \
		-resize 1366x768^ \
		-crop 1366x768+0+0 \
		-composite /tmp/lockcache
fi

xss-lock -- i3lock \
-n \
-i /tmp/lockcache \
--timepos="w-248:h-109" \
--timestr="%a %R" \
--insidecolor=00000000 --ringcolor=00000000 --line-uses-ring \
--keyhlcolor=00000000 --bshlcolor=00000000 --separatorcolor=00000000 \
--insidevercolor=f5f5f599 --insidewrongcolor=f56895ff \
--ringvercolor=00000000 --ringwrongcolor=00000000 \
--timecolor=e8e8e8ff \
--datestr="" \
--veriftext="" \
--wrongtext="" \
--timefont="monospace" \
--timesize="11" \
--radius="2"\
--clock \
--force-clock \
--indpos="x+820:y+329"
