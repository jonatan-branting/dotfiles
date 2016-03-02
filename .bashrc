#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export stuff.
export LD_LIBRARY_PATH+=~/lib/
export PYTHONPATH+=~/lib/
export DESKTOP_SESSION=gnome
export JAVA_HOME=/usr/lib/jvm/java-8-jdk/
export WORKON_HOME=~/.pyenv/versions/
export PANEL_FIFO="/tmp/panel-fifo"
export EDITOR="vim"
export ALTERNATE_EDITOR="emacs"
export QT_STYLE_OVERRIDE=GTK+
export BROWSER="qutebrowser"

PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"
PATH+=":/home/nonah/bin/"
PATH+=":/home/nonah/scripts/"
PATH+=":/home/nonah/lib/"
export PATH

# Aliases
alias pm='sudo pacman'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'
alias flux='xflux -l 58.2 -g 15.4'
alias s='sudo'
alias flux='xflux -l 58.2 -g 15.4'
alias renet='sudo ip link set wlp1s0 down && sudo netctl stop-all && sudo netctl start'
alias rmorphans='sudo pacman -Rns $(pkg-list_true_orphans)'
alias sshliu='ssh -o ciphers=arcfour -o compression=no -y jonbr927@astmatix.ida.liu.se'
alias tddb68='fsliu && urxvtc -e "sshliu" &'
alias ls='ls --color=auto'
alias sn='urxvtc -cd $(pwd)'
alias buffalo='sudo mount -t cifs //192.168.10.15/share /mnt/server -o user=admin,password=zackattack'
alias chrome='google-chrome-unstable --force-device-scale-factor=1'

# functions
function fsliu {
  sshfs -o ciphers=arcfour -o compression=no jonbr927@astmatix.ida.liu.se:/home/$1/ ~/remote
}

function swnet {
  sudo netctl-auto switch-to $1
}

function smbcon {
#To get ip: nmblookup <hostname>
  sudo mount -t cifs //$1 /mnt/server
}

desktop_config(){
  bspc config $1 $2
  for M in $(bspc query -D); do
    bspc config -d $M $1 $2
  done
}

# fix ctrl-w
stty werase undef
bind '\C-w:unix-filename-rubout'

# Prompt
PS1='(\W) >> '
