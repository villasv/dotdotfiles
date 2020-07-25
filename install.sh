#!/bin/bash -e

# System

## Base Packages
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install vim curl wget jq make build-essential

## Fonts
sudo apt install fontconfig
mkdir -p /usr/share/fonts/truetype/cascadia
sudo wget -qP /usr/share/fonts/truetype/cascadia "https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaPL.ttf"
sudo wget -qP /usr/share/fonts/truetype/cascadia "https://github.com/microsoft/cascadia-code/releases/download/v1911.21/CascadiaMonoPL.ttf"
fc-cache -f -v

## Bootstrap Dotfiles
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

ln -sf "$DOTS/.profile"   "$HOME/.profile"
ln -sf "$DOTS/.bashrc"   "$HOME/.bashrc"
ln -sf "$DOTS/.vimrc"     "$HOME/.vimrc"
ln -sf "$DOTS/.gitconfig" "$HOME/.gitconfig"
sudo ln -sf "$DOTS/wsl.conf"   "/etc/wsl.conf"


# Installer Methods

install_github_binary() {
  sudo wget -qP /usr/local/bin "https://raw.githubusercontent.com/$1/$2/$3"
  sudo chmod +x "/usr/local/bin/$3"
}
install_github_script() {
  curl -fsSL "https://raw.githubusercontent.com/$1/$2/$3" | sh
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
install_github_source() {
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


# Runtimes

## Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
. $HOME/.nvm/nvm.sh
nvm install 10.14.1

## Python
curl -fsSL https://pyenv.run | sh
pyenv install 3.8.5 && pyenv global 3.8.5

## Ruby
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
rbenv install 2.7.1 && rbenv global 2.7.1

## Rust
curl -fsSL https://sh.rustup.rs | sh -s -- -y

## Shell Script
sudo apt -qq install shellcheck


# CLI Goodies

## Starship
curl -fsSL https://starship.rs/install.sh | bash
## ripgrep
install_github_debian BurntSushi/ripgrep
## fzf
install_github_source junegunn/fzf
## tl;dr
cargo install tealdeer
## fuck
pip install --user thefuck
## shell demo tools
pip install --user termtosvg cowsay
