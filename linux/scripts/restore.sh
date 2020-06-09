#!/usr/bin/env bash
target=$1
if [[ $target == "last" ]]; then
	target=$(jq '. | length - 1' /tmp/scratchpad.json)
fi

i3-msg [id="$(jq -r '.['"$target"']' /tmp/scratchpad.json)"] scratchpad show
tmp=$(jq -c '. - [.['"$target"']]' /tmp/scratchpad.json)
echo "$tmp" > /tmp/scratchpad.json
