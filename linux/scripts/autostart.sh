#!/usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )" || exit

# visual 
feh --bg-fill $HOME/.wallpaper &
compton &

# panel
#qadbar &
laptop-detect && cbatticon &

# workspace management
echo '{"1": "'"$HOME"'"}' > /tmp/wmdirs.json &
echo '[]' > /tmp/scratchpad.json &

