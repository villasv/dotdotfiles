. ~/.profile

alias please='while [ $? -ne 0 ]; do !!; done'

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

## pyenv
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## yarn tools
export PATH="/home/villasv/.yarn/bin:$PATH"

