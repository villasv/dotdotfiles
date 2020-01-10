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


# Shell
sudo apt -qq install zsh
install_github_script robbyrussell/oh-my-zsh master tools/install.sh


# Runtimes
## Build Essential
sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev
xz-utils tk-dev libffi-dev liblzma-dev pkg-config

## Node
install_github_script nvm-sh/nvm master install.sh
nvm install 10.14.1

## Python
sudo apt -qq install python-minimal
curl -fsSL https://pyenv.run | sh
pyenv install 3.8.0 && pyenv global 3.8.0

## Rust
curl -fsSL https://sh.rustup.rs | sh -s -- -y


# Tools
## CLI goodies
install_github_debian BurntSushi/ripgrep
install_github_source junegunn/fzf
install_github_binary so-fancy/diff-so-fancy master/third_party/build_fatpack diff-so-fancy
cargo install tealdeer
pip install --user thefuck

## Shellcheck
sudo apt -qq install shellcheck

# Symlinks
ln -sf "$DOTS/.profile"   "$HOME/.profile"
ln -sf "$DOTS/.zshrc"     "$HOME/.zshrc"
ln -sf "$DOTS/.vimrc"     "$HOME/.vimrc"
ln -sf "$DOTS/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTS/wsl.conf"   "/etc/wsl.conf"
