#!/bin/bash -e

# System

## Base Packages
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove
sudo apt -y install vim curl wget jq make build-essential

## Dotfiles
DOTS="$HOME/.dotfiles"

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ "$CURR_DIR" != "$DOTS" ]
then
  echo "Project directory at $CURR_DIR, need to move to $DOTS ..."
  if [ -d "$DOTS" ]
  then
    echo " ... but $DOTS already exists, moving to backup"
    mv "$DOTS" "$DOTS.bkp"
  fi
  mv "$CURR_DIR" "$HOME/.dotfiles"
  echo " [OK]"
fi

ln -sf "$DOTS/.bashrc"   "$HOME/.bashrc"
ln -sf "$DOTS/.bash_login"   "$HOME/.bash_login"
ln -sf "$DOTS/.profile"   "$HOME/.profile"
ln -sf "$DOTS/.vimrc"     "$HOME/.vimrc"
ln -sf "$DOTS/.gitconfig" "$HOME/.gitconfig"
sudo ln -sf "$DOTS/wsl.conf"   "/etc/wsl.conf"


# Runtimes
GITHUB="https://raw.githubusercontent.com"

## Node
if [ ! -d "$HOME/.nvm" ]; then
  NVM_REF="nvm-sh/nvm/master"
  NVM_SRC="install.sh"
  PROFILE=/dev/null curl -fsSL "$GITHUB/$NVM_REF/$NVM_SRC" | bash
  source $HOME/.nvm/nvm.sh
  nvm install --lts
fi

## Python
if [ ! -d "$HOME/.pyenv" ]; then
  curl -fsSL https://pyenv.run | bash
  pyenv install 3.8.5
  pyenv install 2.7.18
  pyenv global 3.8.5 2.7.18
  pip install --upgrade pip
fi

## Ruby
if [ ! -d "$HOME/.rbenv" ]; then
  RBENV_REF="rbenv/rbenv-installer/master"
  RBENV_SRC="bin/rbenv-installer"
  curl -fsSL "$GITHUB/$RBENV_REF/$RBENV_SRC" | bash
  rbenv install 2.7.1
  rbenv global 2.7.1
fi

## Rust
curl -fsSL https://sh.rustup.rs | sh -s -- -y

## Shell
sudo apt -qq install shellcheck


# CLI Goodies

## starship
cargo install starship
## fzf + ripgrep
sudo apt install fzf
cargo install ripgrep
## docs & manuals
cargo install tealdeer
## fuck
pip install --user thefuck
## shell demo tools
gem install lolcat
pip install --user termtosvg cowsay
