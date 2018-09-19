#!/bin/bash

lrp () { # latest release matching
  curl -L --silent "https://api.github.com/repos/$1/releases/latest" | jq -r '.assets[].browser_download_url' | grep deb
}
lrp_dpkg () {
  PNAME=${1##*/}
  PRURL=$(lrp $1)
  RFILE=${PRURL##*/}

  if [ ! -f ~/.dotfiles/$RFILE.lock ];
  then
    echo Installing latest $PNAME: $RFILE
    curl -L $PRURL --output ~/.dotfiles/$RFILE
    sudo dpkg -i ~/.dotfiles/$RFILE \
      && touch ~/.dotfiles/$RFILE.lock \
      && rm $RFILE
  else
    echo "$PNAME already the newest version ($RFILE)."
  fi
}
lrp_dpkg BurntSushi/ripgrep

ltb () { # latest tag tarball
  curl -L --silent "https://api.github.com/repos/$1/tags" | jq -r '.[0].tarball_url'
}
ltb_install () {
  PNAME=${1##*/}
  PRURL=$(ltb $1)
  RFILE=${PRURL##*/}

  if [ ! -f ~/.dotfiles/$PNAME_$RFILE.lock ];
  then
    echo Installing latest $PNAME: $RFILE
    mkdir -p ~/.fzf \
      && curl -L $PRURL | tar -xz -C ~/.$PNAME --strip-components=1 \
      && ~/.$PNAME/install \
      && touch ~/.dotfiles/$PNAME_$RFILE.lock
  else
    echo "$PNAME already the newest version ($RFILE)."
  fi
}
ltb_install junegunn/fzf

sudo apt -qq install jq

ln -sf ~/.dotfiles/.zshrc ~/.gitconfig
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

