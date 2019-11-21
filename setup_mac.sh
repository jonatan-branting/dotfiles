#! /bin/bash

cd $HOME
mkdir git
mkdir bin
cd git

git clone https://github.com/jonatan-branting/dotfiles 
git clone https://github.com/jonatan-branting/yabai 

ln -s yabai $HOME/.config/
ln -s shkd $HOME/.config/
ln -s nvim $HOME/.config/
ln -s fish $HOME/.config/
ln -s com.googlecode.iterm2.plist $HOME/Library/Preferences/
ln -s start_iterm.sh $HOME/bin/
ln -s toggle_monocle.sh $HOME/bin/

cd $HOME

brew tap jonatan-branting/forks
brew tap koekeishiya/skhd
brew install pyenv pyenv-virtualenv neovim wget yabai-fork skhd 
brew cask install iterm2

pyenv install 3.8.0
pyenv install 2.7.14
pyenv virtualenv 3.8.0 neovim3
pyenv virtualenv 2.7.14 neovim2
