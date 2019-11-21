#! /bin/bash

cd $HOME
mkdir git; cd git

git clone https://github.com/jonatan-branting/dotfiles 
git clone https://github.com/jonatan-branting/yabai 

ln -s yabai $HOME/.config/
ln -s shkd $HOME/.config/
ln -s nvim $HOME/.config/
ln -s fish $HOME/.config/
ln -s com.googlecode.iterm2.plist $HOME/Library/Preferences/

cd $HOME

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap jonatan-branting/forks
brew tap koekeishiya/skhd
brew install pyenv pyenv-virtualenv neovim wget yabai-fork skhd

pyenv install 3.8.0
pyenv install 2.7.14
pyenv virtualenv 3.8.0 neovim3
pyenv virtualenv 2.7.14 neovim2
