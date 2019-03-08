. ~/.profile

export ZSH=/home/villasv/.oh-my-zsh
ZSH_THEME="agnoster"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

## fzf bootstrap
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# WSL specific
## useful mount link
[[ ! -e /c/ ]] && sudo ln -s /mnt/c /
cd $(pwd | sed 's/\/mnt\/c\//\/c\//')

## docker-toolbox boostrap
export VBOX_MSI_INSTALL_PATH='/mnt/c/Program Files/Oracle/VirtualBox/'
pushd '/mnt/c/Program Files/Docker Toolbox/' > /dev/null
./start.sh exit > /dev/null
eval $(./docker-machine.exe env --shell bash | sed 's?\\?/?g;s?C:/?/mnt/c/?g')
popd > /dev/null

## pyenv
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

