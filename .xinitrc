#!/bin/sh
# -nonah

# VARIABLES.
USERHOME=/home/nonah/
userresources=$USERHOME/.Xresources
xcolorscheme=$USERHOME/.config/xcolors/hybrid.xresources
wallpaper=$USERHOME/pictures/frozengrass.jpg

# Apply system wide settings.
xrdb -merge "$userresources"        # Merge .Xresources.
xrdb -merge "$xcolorscheme"         # Set the URXvt color scheme.
syndaemon -t -k -i 1 -d &           # Fix cursor jumping all over the place.

# Export variables.
export QT_STYLE_OVERRIDE=gtk

# Set key map.
xmodmap ~/.Xmodmap

# Set WP and start programs.
feh --bg-fill "$wallpaper"              # Setting the wallpaper.
dunst -conf ~/.config/dunst/actionsrc & # Notification manager.
compton -b                              # --xrender-sync --xrender-sync-fence                          # Compositing.
flux &                                  # Better color temperature.

# Commands to be run on boot.
$USERHOME/bin/boot.sh

# Start WM.
exec i3
