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
alias vienv       '. .env/bin/activate.fish' # Activates a virtualenv environment. Assumes the env is "stored" in .env.
alias lsdev     'sudo fdisk -l'
alias vim       'nvim'
alias cdb       'mysql -h db-und.ida.liu.se -u jonbr927 -p jonbr927 --password=jonbr927ebdb'
alias dbbu      'mysqldump -h db-und.ida.liu.se -u jonbr927 -p jonbr927 --password=jonbr927ebdb >'
alias vi        'vim'

function chrome
  nohup chromebin 2>/dev/null 1>/dev/null &
end

# Functions
function fsliu
  sshfs -o Ciphers=arcfour -o Compression=no jonbr927@astmatix.ida.liu.se:/home/$argv/ ~/remote
end

function seticons
  gsettings set org.gnome.desktop.interface icon-theme $argv
  gconftool-2 --set --type string /desktop/gnome/interface/icon_theme $argv
  sed -i '/^gtk-icon-theme-name/s/"[^"]*"/"$argv"/' ~/.gtkrc-2.0
  sed -i '/^gtk-icon-theme-name/s/=[^=$]*$/=$argv/' ~/.config/gtk-3.0/settings.ini
end
 


function swnet
  sudo netctl-auto switch-to $argv
end

function please
  sudo $history[1]
end
