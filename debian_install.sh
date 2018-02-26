#!/bin/bash
# close my repo

# TODO: 
# 1)link the folders for sources
# 2)find better sources 
sudo apt-get install git
mkdir ~/.repos
cd ~..repos
git clone https://github.com/piotrkukielka/dotfiles.git

sudo apt update

# install vim and neovim
sudo apt-get install vim
sudo apt-get install -t unstable neovim

# resolve errors at start
sudo apt-get install firmware-amd-graphics firmware-realtek

# install important stuff
sudo apt install -t sid firefox
sudo apt install i3 suckless-tools tmux zsh compton exuberant-ctags gcc g++
sudo apt install autoconf libev-dev shutter

# installing alacritty
sudo apt-get -t unstable install cmake libfreetype6-dev libfontconfig1-dev xclip
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cd ~/.repos
git clone https://github.com/jwilm/alacritty.git
cd alacritty
rustup override set stable
rustup update stable
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
cp Alacritty.desktop ~/.local/share/applications
cd

# installing i3-gaps and i3blocks-gaps
sudo apt install libstartup-notification0-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev
sudo apt install xcb libxcb-util0-dev libxcb-cursor-dev libx11-xcb-dev libxcb-keysyms1-dev libxcb-icccm4-dev
sudo apt install libxcb-xrm-dev feh 
sudo apt install libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev
sudo apt install libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev
sudo apt install libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev
sudo apt-get install libxcb-randr0-dev libxcb-xtest0-dev libxcb-xinerama0-dev libxcb-shape0-dev libxcb-xkb-dev
cd ~/.repos
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd

sudo apt install i3blocks
cd ~/.repos
git clone https://github.com/Airblader/i3blocks-gaps.git
cd i3blocks-gaps
make
sudo make install
cd

# for compton
sudo apt-get install libgl1-mesa-dev

# redshift
sudo apt install redshift

# for nvim plugins
sudo apt install clang
