#!/usr/bin/env bash
workspaces=$(i3-msg -t get_workspaces)
target=$(echo "$workspaces" | jq '.['"$1"'].num')
if [[ $target == "null" ]]; then
	target=$(($(echo "$workspaces" | jq '.[-1].num') + 1))
	fish -c 'cwmd (pwmd) '"$target"
fi
i3-msg move container to workspace "$target"
