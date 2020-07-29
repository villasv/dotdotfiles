#!/bin/bash -e

# System

## Base Packages
sudo apt -y update
sudo apt -y upgrade
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
  PROFILE=/dev/null curl -fsSL \
    "$GITHUB/nvm-sh/nvm/master/install.sh" | sh
  source $HOME/.nvm/nvm.sh
  nvm install 10.14.1
fi

## Python
if [ ! -d "$HOME/.pyenv" ]; then
  curl -fsSL https://pyenv.run | sh
  pyenv install 3.8.5
  pyenv install 2.7.18
  pyenv global 3.8.5 2.7.18
fi

## Ruby
if [ ! -d "$HOME/.rbenv" ]; then
  sh_github rbenv/rbenv-installer master bin/rbenv-installer
  curl -fsSL "$GITHUB/rbenv/rbenv-installer/master/bin/rbenv-installer" | sh
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
pip install --user termtosvg cowsay
