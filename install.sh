#!/bin/bash
############################
# .make.sh

#nvim backup dirs, only if don't exis already
mkdir -p ~/.vim/tmp/swap
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backup

#install iosevka
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Iosevka.zip
unzip Iosevka.zip
cp Iosevka\ Nerd\ Font\ Complete.ttf ~/.fonts/Iosevka.ttf
fc-cache -rv
rm  Iosevka*


#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#create symlinks
ln -svf ~/.repos/dotfiles/init.vim ~/.config/nvim/init.vim 
ln -svf ~/.repos/dotfiles/config__i3 ~/.config/i3/config
ln -svf ~/.repos/dotfiles/tmux.conf ~/.tmux.conf
ln -svf ~/.repos/dotfiles/tmux.reset.conf ~/.tmux.reset.conf
ln -svf ~/.repos/dotfiles/zshrc ~/.zshrc
ln -svf ~/.repos/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

#install compton to reduce tearing


