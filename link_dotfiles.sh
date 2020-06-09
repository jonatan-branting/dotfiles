#! /bin/bash

# TODO make errors silent, but report what succesfully got linked
# TODO reuse the config function in all linkers
# TODO maybe not include the fisher packages scripts...

# Script-location, no matter what
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Linking general dotfiles..."

function symlink_config {
    localdir=$dir/$1
    contents="$(ls $localdir/config)"
    for e in $contents; do 
        ln -s $localdir/config/$e $HOME/.config/
    done
}

function symlink_bin {
    localdir=$dir/$1
    ln -s $localdir/bin $HOME/
}


symlink_config
if [[ "$1" -eq "mac" ]]; then
    symlink_config mac
    symlink_bin mac
fi


echo "Done"
