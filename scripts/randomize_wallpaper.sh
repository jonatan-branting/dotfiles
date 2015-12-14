#!/bin/bash

WALLS_DIR=$HOME/pictures/active
feh --bg-fill "$(find $WALLS_DIR/ -type f -name "*.jpg" -o -name "*.png" | shuf -n1)"
