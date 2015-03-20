#!/bin/sh
# -nonah

# VARIABLES.
USERHOME=/home/nonah/
userresources=$USERHOME/.Xresources
xcolorscheme=$USERHOME/.config/xcolors/grey.xresources
wallpaper=$USERHOME/pictures/diamond.jpg

# Apply system wide settings.
xrdb -merge "$userresources"        # Merge .Xresources.
xrdb -merge "$xcolorscheme"         # Set the URXvt color scheme.
syndaemon -t -k -i 1 -d &           # Fix cursor jumping all over the place.

# Export variables
export QT_STYLE_OVERRIDE=gtk

# Set WP and start programs.
feh --bg-fill "$wallpaper"          # Setting the wallpaper.
urxvtd -q -o -f                     # URXvt daemon.
dunst &                             # Notification manager.
sxhkd &                             # WM Keybindings.
compton -b                          # Compositing.
flux                                # Better color temperature.

# Commands to be run on boot.
$USERHOME/bin/boot.sh

# Start WM.
exec bspwm
