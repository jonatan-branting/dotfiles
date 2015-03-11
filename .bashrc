#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export stuff to PATH.
export PATH=/home/nonah/lib/:$PATH

# Aliases
alias pm='sudo pacman'
alias reboot='sudo systemctl reboot'
alias shutdown='sudo systemctl poweroff'
alias vi='vim'
alias flux='xflux -l 58.2 -g 15.4'
alias s='sudo'
alias flux='xflux -l 58.2 -g 15.4'
alias renet='sudo ip link set wlp1s0 down && sudo netctl stop-all && sudo netctl start'
alias rmorphans='sudo pacman -Rns $(pkg-list_true_orphans)'
alias sshliu='ssh -o Ciphers=arcfour -o Compression=no -Y jonbr927@astmatix.ida.liu.se'
alias tddb68='fsliu && urxvtc -e "sshliu" &'
alias ls='ls --color=auto'
alias sn='urxvtc -cd $(pwd)'

alias buffalo='sudo mount -t cifs //192.168.10.15/Share /mnt/server -o user=admin,password=Zackattack'

# Functions
function fsliu {
  sshfs -o Ciphers=arcfour -o Compression=no jonbr927@astmatix.ida.liu.se:/home/$1/ ~/remote
}

# Fix Ctrl-W
stty werase undef
bind '\C-w:unix-filename-rubout'

# Prompt
PS1='(\W) >> '
