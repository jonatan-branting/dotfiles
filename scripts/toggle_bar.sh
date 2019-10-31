#!/bin/sh

# Check if xdo is installed
xdo_path=$(which xdo)
if [ $? -ne 0 ]; then
    echo "Cannot find \`xdo\` command." 1>&2
    exit 1
fi

id=$(xdo id -N "Polybar")

if [ $# -ne 1 ];
  then
   # Toggle bar visibility
    if xprop -id $id | grep -q "Normal"; then
      xdo hide -N "Polybar"
    else
      xdo show -N "Polybar"
    fi
else
  if [ $1 -eq 1 ]; then
    xdo hide -N "Polybar"
  fi

  if [ $1 -eq 0 ]; then
    xdo show -N "Polybar"
  fi
fi
