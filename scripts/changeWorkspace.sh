#!/usr/bin/env bash
workspaces=$(i3-msg -t get_workspaces)

moveWorkspace() {
	if echo "$workspaces" | jq -e '[.[].num] | contains(['"$1"'])'; then
		# if this workspace exists, shift successors recursively
		moveWorkspace $(($1 + 1))
		# then move this workspace
		fish -c 'cwmd (pwmd '"$1"') '"$(($1 + 1))"
		i3-msg rename workspace "$1" to $(($1 + 1))
	fi
}

new() {
	# free a space for the new workspace
	moveWorkspace $(($1 + 1))
	# change working directory
	fish -c "cwmd \"$2\" \"$(($1 + 1))\""
	# create new workspace
	i3-msg workspace $(($1+1))
}

if [[ $1 == "new" ]]; then
	new "$(echo "$workspaces" | jq '.[] | select(.focused).num')" "$(fish -c 'pwmd')"
else
	target=$(echo "$workspaces" | jq '.['"$1"'].num')
	if [[ $target != "null" ]]; then
		# if the target workspace exists, switch to it
		i3-msg workspace "$target"
	else
		# otherwise, create a new workspace after the last one
		new "$(echo "$workspaces" | jq '.[-1].num')" "$HOME"
	fi
fi
ps -ef | grep workingDirectory.sh | head -n 1 | awk '{print $2}' | xargs kill -s SIGUSR1 ^ /dev/null
