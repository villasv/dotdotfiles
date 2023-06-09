#!/bin/bash -e

RGH="https://raw.githubusercontent.com"

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

## Homebrew
if ! [ -x "$(command -v brew)" ]
then
  curl -fsSL "$RGH/Homebrew/install/HEAD/install.sh" | bash
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

## Shell
ln -sf "$DOTS/.zshrc"      "$HOME/.zshrc"
ln -sf "$DOTS/.zprofile"   "$HOME/.zprofile"
brew install starship shfmt
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

brew install fzf
! [ "$HOME/.fzf.zsh" ] && $(brew --prefix)/opt/fzf/install

## Git
ln -sf "$DOTS/.gitconfig"  "$HOME/.gitconfig"
ln -sf "$DOTS/.gitignore"  "$HOME/.gitignore"

## Vim
ln -sf "$DOTS/.vimrc"      "$HOME/.vimrc"
brew install neovim

## Python
pip3 install --upgrade pip
export PATH="$HOME/.pyenv/bin:$PATH"
if [ ! -d "$HOME/.pyenv" ]; then
  curl -fsSL https://pyenv.run | bash
fi

## Node
if [ ! -d "$HOME/.nvm" ]; then
  PROFILE=/dev/null curl -fsSL "$RGH/nvm-sh/nvm/HEAD/install.sh" | bash
  source "$HOME/.nvm/nvm.sh"
  nvm install --lts
fi
