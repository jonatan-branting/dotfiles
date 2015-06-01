alias pm        'sudo pacman'
alias reboot    'sudo systemctl reboot'
alias shutdown  'sudo systemctl poweroff'
alias flux      'xflux -l 58.2 -g 15.4'
alias s         'sudo'
alias flux      'xflux -l 58.2 -g 15.4'
alias renet     'sudo ip link set wlp1s0 down; and sudo netctl stop-all; and sudo netctl start'
alias rmorphans 'sudo pacman -Rns (pkg-list_true_orphans)'
alias sshliu    'ssh -o Ciphers=arcfour -o Compression=no -Y jonbr927@astmatix.ida.liu.se'
alias tddb68    'fsliu; and urxvtc -e "sshliu" &'
alias ls        'ls --color=auto'
alias sn        'urxvtc -cd (pwd)'
alias buffalo   'sudo mount -t cifs //192.168.10.15/Share /mnt/server -o user=admin,password=Zackattack'
alias chrome    'google-chrome-unstable --force-device-scale-factor=1'


# Functions
function fsliu
  sshfs -o Ciphers=arcfour -o Compression=no jonbr927@astmatix.ida.liu.se:/home/$argv/ ~/remote
end


function swnet
  sudo netctl-auto switch-to $argv
end

function please
  sudo $history[1]
end
