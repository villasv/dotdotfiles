#!/bin/sh
# ⏱ 0.030

# shellcheck source=.profile
. "$HOME/.profile"
# ⏱ 0.150

alias please='while [ $? -ne 0 ] && [ $? -le 130 ]; do eval "$(fc -ln -1)"; done'

export ZSH=/home/villasv/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git)
source $ZSH/oh-my-zsh.sh


# Tools
## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## thefuck
eval "$(thefuck --alias)"
