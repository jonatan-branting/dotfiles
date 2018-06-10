#!/bin/sh
# -nonah

# VARIABLES.
USERHOME=/home/nonah/
userresources=$USERHOME/.Xresources
xcolorscheme=$USERHOME/.config/xcolors/hybrid.xresources
wallpaper=$USERHOME/pictures/blurryflower.jpg

# Apply system wide settings.
xrdb -merge "$userresources"        # Merge .Xresources.
xrdb -merge "$xcolorscheme"         # Set the URXvt color scheme.
syndaemon -t -k -i 1 -d &           # Fix cursor jumping all over the place.

# Export variables.
export QT_STYLE_OVERRIDE=gtk

# Set key map.
xmodmap ~/.Xmodmap

# Set WP and start programs.
feh --bg-fill "$wallpaper"          # Setting the wallpaper.
dunst &                             # Notification manager.
#sxhkd &                             # WM Keybindings.
#compton -b #--xrender-sync --xrender-sync-fence                          # Compositing.
#flux                                # Better color temperature.

# Commands to be run on boot.
$USERHOME/bin/boot.sh

# Start WM.
#exec gnome-session
#exec openbox
#exec awesome
#exec bspwm
#exec twm
flashfocus &
exec i3
#exec startkde
