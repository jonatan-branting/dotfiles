#!/usr/bin/env bash

set -e

osascript - <<EOF

on is_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_running

tell application "iTerm2"
    # activate
    create window with default profile
end tell
EOF
