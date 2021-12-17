#!/bin/bash -e

## Homebrew
if ! [ -x "$(command -v brew)" ]
then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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

ln -sf "$DOTS/.vimrc"      "$HOME/.vimrc"
ln -sf "$DOTS/.gitconfig"  "$HOME/.gitconfig"

## Shell
ln -sf "$DOTS/.zshrc"      "$HOME/.zshrc"
ln -sf "$DOTS/.zprofile"   "$HOME/.zprofile"
brew install starship

