. ~/.profile

alias please='while [ $? -ne 0 ]; do !!; done'

export ZSH=/home/villasv/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh

# Runtimes
## Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## Python
export PATH="/home/villasv/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Tools
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
## thefuck
eval $(thefuck --alias)
