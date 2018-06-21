#!/bin/bash

lrm () { # latest release matching
  curl -L --silent "https://api.github.com/repos/$1/releases/latest" | jq -r '.assets[].browser_download_url' | grep $2
}
lrm_deb () {
  PNAME=${1##*/}
  PRURL=$(lrm $1 deb)
  RFILE=${PRURL##*/}

  if [ ! -f ~/.dotfiles/$RFILE.lock ];
  then
    echo Installing latest $PNAME: $RFILE
    curl -L $PRURL --output ~/.dotfiles/$RFILE
    sudo dpkg -i ~/.dotfiles/$RFILE \
      && touch ~/.dotfiles/$RFILE.lock \
      && rm $RFILE
  else
    echo Latest $PNAME already installed
  fi
}

lrm_deb BurntSushi/ripgrep

ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.bashrc ~/.bashrc

