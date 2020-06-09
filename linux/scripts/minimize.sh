#!/usr/bin/env bash

if [ ! -f /tmp/scratchpad.json ]; then
	echo '[]' > /tmp/scratchpad.json
fi

tmp=$(jq -c '. + ["'"$(xdotool getactivewindow)"'"]' /tmp/scratchpad.json)
echo "$tmp" > /tmp/scratchpad.json
i3-msg move scratchpad
