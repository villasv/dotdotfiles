#!/bin/bash -e

# System

## Node
if [ ! -d "$HOME/.nvm" ]; then
  NVM_REF="nvm-sh/nvm/master"
  NVM_SRC="install.sh"
  PROFILE=/dev/null curl -fsSL "$GITHUB/$NVM_REF/$NVM_SRC" | bash
  source "$HOME/.nvm/nvm.sh"
  nvm install --lts
fi

## Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
if [ ! -d "$HOME/.rbenv" ]; then
  RBENV_REF="rbenv/rbenv-installer/master"
  RBENV_SRC="bin/rbenv-installer"
  curl -fsSL "$GITHUB/$RBENV_REF/$RBENV_SRC" | bash
  rbenv install 3.0.2
  rbenv global 3.0.2
fi

## Rust
curl -fsSL https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

## Shell
sudo apt -qq install shellcheck


# CLI Goodies

## fzf + ripgrep
cargo install ripgrep
## docs & manuals
cargo install tealdeer
## fuck
pip install --user thefuck
## shell demo tools
gem install lolcat
pip install --user termtosvg cowsay
