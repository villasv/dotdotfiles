#!/bin/bash

DOTS="$HOME/.dotfiles"


# Bootstrap Dotfiles
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


# Installer Methods
install_github_script() {
  sh -c "$( curl -fsSL "https://raw.githubusercontent.com/$1/$2/$3" )"
}
install_github_debian() {
  DEB_URL="$(
    curl -fsSL "https://api.github.com/repos/$1/releases/latest" |\
    jq -r '.assets[].browser_download_url' | grep deb
  )"
  PROJECT=${1##*/}
  RELEASE=${DEB_URL##*/}
  LOCKFILE="$DOTS/${PROJECT}_${RELEASE}.lock"
  if [ ! -f "$LOCKFILE" ];
  then
    echo "Newer release found for $PROJECT: $RELEASE ..."
    curl -fsSL "$DEB_URL" --output "$DOTS/$RELEASE" \
      && sudo dpkg -i "$DOTS/$RELEASE" \
      && rm "$DOTS/$RELEASE" \
      && touch "$LOCKFILE"
  else
    echo "$PROJECT is already the newest version ($RELEASE)."
  fi
}
install_github_tartag() {
  TAR_URL="$(
    curl -fsSL "https://api.github.com/repos/$1/tags" |\
    jq -r '.[0].tarball_url'
  )"
  PROJECT=${1##*/}
  RELEASE=${TAR_URL##*/}
  LOCKFILE="$DOTS/${PROJECT}_${RELEASE}.lock"
  if [ ! -f "$LOCKFILE" ];
  then
    echo "Newer release found for $PROJECT: $RELEASE ..."
    mkdir -p "$HOME/.$PROJECT" \
      && curl -fsSL "$TAR_URL" | tar -xz -C "$HOME/.$PROJECT" --strip-components=1 \
      && yes | "$HOME/.$PROJECT/install" \
      && touch "$LOCKFILE"
  else
    echo "$PROJECT is already the newest version ($RELEASE)."
  fi
}


# Tools
## ZSH
sudo apt -qq install zsh
install_github_script robbyrussell/oh-my-zsh master tools/install.sh

## CLI goodies
install_github_debian BurntSushi/ripgrep
install_github_tartag junegunn/fzf

# Symlinks
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
